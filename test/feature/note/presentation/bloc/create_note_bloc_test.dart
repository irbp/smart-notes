import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:smart_notes/core/error/app_error.dart';
import 'package:smart_notes/core/presentation/ui_error/error_mapper.dart';
import 'package:smart_notes/core/presentation/ui_error/error_strings.dart';
import 'package:smart_notes/feature/note/presentation/bloc/create_note_bloc.dart';

import '../../fake/note_params_fake.dart';
import '../../mock/save_note_use_case_mock.dart';

void main() {
  late SaveNoteUseCaseMock saveNote;
  late ErrorMapper errorMapper;
  late CreateNoteBloc createNoteBloc;

  setUpAll(() {
    registerFallbackValue(NoteParamsFake());
  });

  setUp(() {
    saveNote = SaveNoteUseCaseMock();
    errorMapper = ErrorMapper();
    createNoteBloc = CreateNoteBloc(
      saveNote: saveNote,
      errorMapper: errorMapper,
    );
    when(() => saveNote(any())).thenAnswer((_) async => Result.success(''));
  });

  test('initial state should be empty', () {
    final expected = CreateNoteState.initialState();

    final actual = createNoteBloc.state;
    expect(actual, equals(expected));
  });

  blocTest(
    'on title changed, update state with the new title (title not empty)',
    build: () => createNoteBloc,
    seed: () => createValidState().copyWith(
      title: '',
      enableSaveButton: false,
    ),
    act: (bloc) => bloc.add(const CreateNoteTitleChanged('Title')),
    expect: () => [createValidState()],
  );

  blocTest(
    'on title changed, update state with the new title (title is empty)',
    build: () => createNoteBloc,
    seed: () => createValidState(),
    act: (bloc) => bloc.add(const CreateNoteTitleChanged('')),
    expect: () => [
      createValidState().copyWith(title: '', enableSaveButton: false),
    ],
  );

  blocTest(
    'on description changed, update state with the new description (description not empty)',
    build: () => createNoteBloc,
    seed: () => createValidState().copyWith(
      description: '',
      enableSaveButton: false,
    ),
    act: (bloc) => bloc.add(const CreateNoteDescriptionChanged('Description')),
    expect: () => [createValidState()],
  );

  blocTest(
    'on description changed, update state with the new description (description is empty)',
    build: () => createNoteBloc,
    seed: () => createValidState(),
    act: (bloc) => bloc.add(const CreateNoteDescriptionChanged('')),
    expect: () => [
      createValidState().copyWith(description: '', enableSaveButton: false),
    ],
  );

  blocTest(
    'on save note button pressed, update state correctly (note is saved with success)',
    build: () => createNoteBloc,
    seed: () => createValidState(),
    act: (bloc) => bloc.add(CreateNoteButtonPressed()),
    expect: () => [
      createValidState().copyWith(showLoadingProgress: true),
      createValidState().copyWith(navigateUpWithSuccess: true),
    ],
  );

  blocTest(
    'on save note button pressed, update state correctly (note is not saved with success)',
    build: () => createNoteBloc,
    setUp: () {
      when(() => saveNote(any()))
          .thenAnswer((_) async => Result.error(GenericError()));
    },
    seed: () => createValidState(),
    act: (bloc) => bloc.add(CreateNoteButtonPressed()),
    expect: () => [
      createValidState().copyWith(showLoadingProgress: true),
      createValidState().copyWith(errorMessage: ErrorStrings.genericError),
    ],
  );
}

CreateNoteState createValidState() {
  return CreateNoteState.initialState().copyWith(
    title: 'Title',
    description: 'Description',
    enableSaveButton: true,
  );
}
