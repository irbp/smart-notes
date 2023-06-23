import 'dart:async';

import 'package:hive/hive.dart';
import 'package:smart_notes/feature/note/data/data_source/notes_local_data_source.dart';
import 'package:smart_notes/feature/note/domain/entity/note.dart';

class NotesLocalDataSourceImpl implements NotesLocalDataSource {
  NotesLocalDataSourceImpl({required Box<Note> noteBox}) : _noteBox = noteBox;

  final Box<Note> _noteBox;

  @override
  Future<void> saveNote(Note note) async {
    return await _noteBox.put(note.id.toString(), note);
  }

  @override
  Stream<List<Note>> getNotesStream() async* {
    yield _noteBox.values.toList();
    yield* _noteBox.watch().map((event) => _noteBox.values.toList());
  }

  @override
  Future<void> removeNote(Note note) async {
    return await _noteBox.delete(note.id.toString());
  }
}
