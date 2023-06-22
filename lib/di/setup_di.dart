import 'package:smart_notes/database/di/setup_database_di.dart';
import 'package:smart_notes/feature/note/di/setup_note_di.dart';

Future<void> registerAppDependencies() async {
  registerNoteFeatureDependencies();
  await registerDatabaseDependencies();
}
