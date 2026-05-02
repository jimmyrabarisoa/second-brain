import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/database/database_provider.dart';
import '../../../../core/sync/sync_service.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../models/note_mapper.dart';

final noteRepositoryProvider = Provider<NoteRepository>((ref) {
  return NoteRepositoryImpl(
    db: ref.watch(databaseProvider),
    syncService: ref.watch(syncServiceProvider),
  );
});

class NoteRepositoryImpl implements NoteRepository {
  final AppDatabase _db;
  final SyncService _syncService;
  final _uuid = const Uuid();

  NoteRepositoryImpl({required AppDatabase db, required SyncService syncService})
      : _db = db,
        _syncService = syncService;

  @override
  Stream<List<Note>> watchAll() {
    return (_db.select(_db.notesTable)
          ..where((t) => t.deletedAt.isNull())
          ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
        .watch()
        .map((rows) => rows.map((r) => r.toDomain()).toList());
  }

  @override
  Future<Note?> getById(String id) async {
    final row = await (_db.select(_db.notesTable)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row?.toDomain();
  }

  @override
  Future<void> save(Note? existing, {String? title, String? content, List<String>? tags}) async {
    final note = existing != null
        ? existing.copyWith(title: title, content: content, tags: tags)
        : Note(
            id: _uuid.v4(),
            title: title ?? '',
            content: content ?? '',
            tags: tags ?? [],
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            isSynced: false,
          );

    await _db.into(_db.notesTable).insertOnConflictUpdate(note.toCompanion());

    await _syncService.enqueue(
      entityType: 'note',
      entityId: note.id,
      operation: existing != null ? 'update' : 'create',
      payload: note.toJson(),
    );

    await _syncService.flush();
  }

  @override
  Future<void> delete(String id) async {
    await (_db.update(_db.notesTable)..where((t) => t.id.equals(id)))
        .write(NotesTableCompanion(deletedAt: Value(DateTime.now())));

    await _syncService.enqueue(
      entityType: 'note',
      entityId: id,
      operation: 'delete',
      payload: {'id': id},
    );

    await _syncService.flush();
  }
}
