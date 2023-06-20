import 'package:get_it/get_it.dart';
import 'package:smart_notes/feature/note/domain/use_case/save_note_use_case.dart';
import 'package:smart_notes/feature/note/domain/use_case/save_note_use_case_impl.dart';

import '../use_case/get_notes_use_case.dart';
import '../use_case/get_notes_use_case_impl.dart';

void registerNoteDomainDependencies() {
  GetIt.I.registerFactory<GetNotesUseCase>(
    () => GetNotesUseCaseImpl(notesRepository: GetIt.I()),
  );
  GetIt.I.registerFactory<SaveNoteUseCase>(
    () => SaveNoteUseCaseImpl(notesRepository: GetIt.I()),
  );
}
