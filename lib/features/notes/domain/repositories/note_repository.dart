import '../entities/note.dart';

abstract class NoteRepository {
  Stream<List<Note>> watchAll();
  Future<Note?> getById(String id);
  Future<void> save(Note note);
  Future<void> delete(String id);
}
