import 'package:smart_notes/feature/note/data/di/setup_note_data_di.dart';
import 'package:smart_notes/feature/note/domain/di/setup_note_domain_di.dart';
import 'package:smart_notes/feature/note/presentation/di/setup_note_presentation_di.dart';

void registerNoteFeatureDependencies() {
  registerNoteDataDependencies();
  registerNoteDomainDependencies();
  registerNotePresentationDependencies();
}
