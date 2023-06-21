import 'package:smart_notes/feature/note/domain/entity/note.dart';

abstract class NotesLocalDataSource {
  Future<void> saveNote(Note note);

  Stream<List<Note>> getNotesStream();
}
