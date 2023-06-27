import 'package:get_it/get_it.dart';
import 'package:smart_notes/core/presentation/ui_error/error_mapper.dart';
import 'package:smart_notes/feature/note/presentation/bloc/create_note_bloc.dart';
import 'package:smart_notes/feature/note/presentation/mapper/save_note_error_mapper.dart';

import '../bloc/home_bloc.dart';

void registerNotePresentationDependencies() {
  GetIt.I.registerFactory<SaveNoteErrorMapper>(
    () => SaveNoteErrorMapper(),
  );
  GetIt.I.registerFactory<ErrorMapper>(
    () => ErrorMapper(domainErrorMapper: GetIt.I<SaveNoteErrorMapper>()),
  );
  GetIt.I.registerFactory<HomeBloc>(
    () => HomeBloc(getNotes: GetIt.I(), removeNote: GetIt.I()),
  );
  GetIt.I.registerFactory<CreateNoteBloc>(
    () => CreateNoteBloc(
      saveNote: GetIt.I(),
      errorMapper: GetIt.I(),
    ),
  );
}
