import 'package:get_it/get_it.dart';

import '../bloc/home_bloc.dart';

void registerNotePresentationDependencies() {
  GetIt.I.registerFactory<HomeBloc>(
    () => HomeBloc(getNotes: GetIt.I()),
  );
}
