import 'package:get_it/get_it.dart';
import 'package:smart_notes/database/app_database.dart';

Future<void> registerDatabaseDependencies() async {
  final database = await AppDatabase.create();
  GetIt.I.registerLazySingleton(() => database);

  final noteBox = await GetIt.I<AppDatabase>().noteBox;
  GetIt.I.registerLazySingleton(() => noteBox);
}
