import 'dart:async';

import 'package:smart_notes/feature/note/data/data_source/notes_local_data_source.dart';
import 'package:smart_notes/feature/note/domain/entity/note.dart';

class NotesLocalDataSourceInMemory implements NotesLocalDataSource {
  final _inMemoryNotesStreamController = StreamController<List<Note>>()
    ..add([]);
  final List<Note> _inMemoryNotes = [];

  @override
  Future<void> saveNote(Note note) async {
    _inMemoryNotes.add(note);
    _inMemoryNotesStreamController.add(_inMemoryNotes.toList());
  }

  @override
  Stream<List<Note>> getNotesStream() => _inMemoryNotesStreamController.stream;
}
