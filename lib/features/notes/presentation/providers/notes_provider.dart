import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/note_repository_impl.dart';
import '../../domain/entities/note.dart';

final notesProvider = StreamProvider<List<Note>>((ref) {
  return ref.watch(noteRepositoryProvider).watchAll();
});
