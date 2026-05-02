import 'dart:convert';
import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/note.dart';

extension NoteMapper on NotesTableData {
  Note toDomain() {
    return Note(
      id: id,
      title: title,
      content: content,
      tags: List<String>.from(jsonDecode(tags)),
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: deletedAt,
      isSynced: isSynced,
    );
  }
}

extension NoteCompanionMapper on Note {
  NotesTableCompanion toCompanion() {
    return NotesTableCompanion(
      id: Value(id),
      title: Value(title),
      content: Value(content),
      tags: Value(jsonEncode(tags)),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: Value(deletedAt),
      isSynced: Value(isSynced),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'tags': tags,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'deletedAt': deletedAt?.toIso8601String(),
      };
}
