// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:smart_notes/core/presentation/ui_error/error_mapper.dart'
    as _i10;
import 'package:smart_notes/feature/note/data/data_source/notes_local_data_source.dart'
    as _i3;
import 'package:smart_notes/feature/note/data/data_source/notes_local_data_source_in_memory.dart'
    as _i4;
import 'package:smart_notes/feature/note/data/repository/notes_repository_impl.dart'
    as _i6;
import 'package:smart_notes/feature/note/domain/repository/notes_repository.dart'
    as _i5;
import 'package:smart_notes/feature/note/domain/use_case/get_notes_use_case.dart'
    as _i11;
import 'package:smart_notes/feature/note/domain/use_case/get_notes_use_case_impl.dart'
    as _i12;
import 'package:smart_notes/feature/note/domain/use_case/save_note_use_case.dart'
    as _i8;
import 'package:smart_notes/feature/note/domain/use_case/save_note_use_case_impl.dart'
    as _i9;
import 'package:smart_notes/feature/note/presentation/bloc/create_note_bloc.dart'
    as _i14;
import 'package:smart_notes/feature/note/presentation/bloc/home_bloc.dart'
    as _i13;
import 'package:smart_notes/feature/note/presentation/mapper/note_error_mapper_module.dart'
    as _i15;
import 'package:smart_notes/feature/note/presentation/mapper/save_note_error_mapper.dart'
    as _i7;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final noteErrorMapperModule = _$NoteErrorMapperModule();
    gh.lazySingleton<_i3.NotesLocalDataSource>(
        () => _i4.NotesLocalDataSourceInMemory());
    gh.factory<_i5.NotesRepository>(() => _i6.NotesRepositoryImpl(
        notesLocalDataSource: gh<_i3.NotesLocalDataSource>()));
    gh.factory<_i7.SaveNoteErrorMapper>(() => _i7.SaveNoteErrorMapper());
    gh.factory<_i8.SaveNoteUseCase>(() =>
        _i9.SaveNoteUseCaseImpl(notesRepository: gh<_i5.NotesRepository>()));
    gh.factory<_i10.ErrorMapper>(
        () => noteErrorMapperModule.getMapper(gh<_i7.SaveNoteErrorMapper>()));
    gh.factory<_i11.GetNotesUseCase>(() =>
        _i12.GetNotesUseCaseImpl(notesRepository: gh<_i5.NotesRepository>()));
    gh.factory<_i13.HomeBloc>(
        () => _i13.HomeBloc(getNotes: gh<_i11.GetNotesUseCase>()));
    gh.factory<_i14.CreateNoteBloc>(() => _i14.CreateNoteBloc(
          saveNote: gh<_i8.SaveNoteUseCase>(),
          errorMapper: gh<_i10.ErrorMapper>(),
        ));
    return this;
  }
}

class _$NoteErrorMapperModule extends _i15.NoteErrorMapperModule {}
