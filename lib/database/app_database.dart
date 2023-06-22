import 'package:hive_flutter/adapters.dart';
import 'package:smart_notes/database/adapter/note_adapter.dart';
import 'package:smart_notes/feature/note/domain/entity/note.dart';

class AppDatabase {
  AppDatabase._();

  Future<Box<Note>> get noteBox async => await Hive.openBox(_noteBoxPath);

  static const _noteBoxPath = 'note';

  static Future<AppDatabase> create() async {
    await Hive.initFlutter();
    _registerAdapters();
    return AppDatabase._();
  }

  static void _registerAdapters() {
    Hive.registerAdapter(NoteAdapter());
  }
}
