import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../database/app_database.dart';
import '../database/database_provider.dart';
import '../network/api_client.dart';
import '../network/connectivity_provider.dart';

final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService(
    db: ref.watch(databaseProvider),
    dio: ref.watch(dioProvider),
    ref: ref,
  );
});

class SyncService {
  final AppDatabase _db;
  final Dio _dio;
  final Ref _ref;

  SyncService({required AppDatabase db, required Dio dio, required Ref ref})
      : _db = db,
        _dio = dio,
        _ref = ref;

  /// Ajoute une opération en file d'attente
  Future<void> enqueue({
    required String entityType,
    required String entityId,
    required String operation,
    required Map<String, dynamic> payload,
  }) async {
    await _db.into(_db.syncQueueTable).insert(SyncQueueTableCompanion(
          entityType: Value(entityType),
          entityId: Value(entityId),
          operation: Value(operation),
          payload: Value(jsonEncode(payload)),
        ));
  }

  /// Vide la queue en envoyant les mutations au serveur
  Future<void> flush() async {
    final isOnline = _ref.read(isOnlineProvider);
    if (!isOnline) return;

    final pending = await (_db.select(_db.syncQueueTable)
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .get();

    for (final item in pending) {
      try {
        await _dio.post(
          '/sync/push',
          data: {
            'entityType': item.entityType,
            'entityId': item.entityId,
            'operation': item.operation,
            'payload': jsonDecode(item.payload),
          },
        );
        await (_db.delete(_db.syncQueueTable)
              ..where((t) => t.id.equals(item.id)))
            .go();
      } on DioException {
        await (_db.update(_db.syncQueueTable)
              ..where((t) => t.id.equals(item.id)))
            .write(SyncQueueTableCompanion(
              retryCount: Value(item.retryCount + 1),
            ));
      }
    }
  }

  /// Récupère les changements serveur depuis le dernier sync
  Future<void> pull(String entityType, DateTime since) async {
    final isOnline = _ref.read(isOnlineProvider);
    if (!isOnline) return;

    await _dio.get('/sync/pull', queryParameters: {
      'entityType': entityType,
      'since': since.toIso8601String(),
    });
    // Le traitement des données reçues est délégué aux repositories
  }
}
