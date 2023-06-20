import 'package:get_it/get_it.dart';
import 'package:smart_notes/feature/note/presentation/bloc/create_note_bloc.dart';

import '../bloc/home_bloc.dart';

void registerNotePresentationDependencies() {
  GetIt.I.registerFactory<HomeBloc>(
    () => HomeBloc(getNotes: GetIt.I()),
  );
  GetIt.I.registerFactory<CreateNoteBloc>(
    () => CreateNoteBloc(saveNote: GetIt.I()),
  );
}
