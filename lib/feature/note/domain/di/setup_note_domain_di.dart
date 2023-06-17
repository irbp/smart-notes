import 'package:get_it/get_it.dart';

import '../use_case/get_notes_use_case.dart';
import '../use_case/get_notes_use_case_impl.dart';

void registerNoteDomainDependencies() {
  GetIt.I.registerFactory<GetNotesUseCase>(
    () => GetNotesUseCaseImpl(notesRepository: GetIt.I()),
  );
}
