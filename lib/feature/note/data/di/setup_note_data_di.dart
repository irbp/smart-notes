import 'package:get_it/get_it.dart';

import '../../domain/repository/notes_repository.dart';
import '../data_source/notes_local_data_source.dart';
import '../data_source/notes_local_data_source_in_memory.dart';
import '../repository/notes_repository_impl.dart';

void registerNoteDataDependencies() {
  GetIt.I.registerLazySingleton<NotesLocalDataSource>(
    () => NotesLocalDataSourceInMemory(),
  );
  GetIt.I.registerFactory<NotesRepository>(
    () => NotesRepositoryImpl(notesLocalDataSource: GetIt.I()),
  );
}
