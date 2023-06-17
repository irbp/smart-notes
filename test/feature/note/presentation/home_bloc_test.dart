import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:smart_notes/core/error/app_error.dart';
import 'package:smart_notes/feature/note/presentation/bloc/home_bloc.dart';

import '../mock/get_notes_use_case_mock.dart';
import '../object_builder/note_builder.dart';

void main() {
  late GetNotesUseCaseMock getNotesMock;
  late HomeBloc homeBloc;

  setUp(() {
    getNotesMock = GetNotesUseCaseMock();
    homeBloc = HomeBloc(getNotes: getNotesMock);
    when(() => getNotesMock())
        .thenAnswer((_) async => Result.success(NoteBuilder.buildList()));
  });

  test('initial state should be loading', () {
    final expected = HomeLoadInProgress();

    final actual = homeBloc.state;
    expect(actual, equals(expected));
  });

  blocTest(
    'given init screen event, update state to succes if the notes is loaded with success',
    build: () => homeBloc,
    act: (bloc) => bloc.add(HomeInitScreen()),
    expect: () => [HomeLoadSuccess(notes: NoteBuilder.buildList())],
  );

  blocTest(
    'given init screen event, update state to failure if the notes is not loaded with success',
    build: () => homeBloc,
    setUp: () {
      when(() => getNotesMock())
          .thenAnswer((_) async => Result.error(GenericError()));
    },
    act: (bloc) => bloc.add(HomeInitScreen()),
    expect: () => [HomeLoadFailure()],
  );

  blocTest<HomeBloc, HomeState>(
    'given add button pressed event, update state to show snackbar if the current state is success',
    build: () => homeBloc,
    act: (bloc) => bloc.add(HomeAddButtonPressed()),
    seed: () => HomeLoadSuccess(notes: NoteBuilder.buildList()),
    expect: () => [
      HomeLoadSuccess(notes: NoteBuilder.buildList(), showSnackbar: true),
    ],
  );

  blocTest<HomeBloc, HomeState>(
    'given add button pressed event, do not update state to show snackbar if the current state is failure',
    build: () => homeBloc,
    act: (bloc) => bloc.add(HomeAddButtonPressed()),
    seed: () => HomeLoadFailure(),
    expect: () => [],
  );

  blocTest<HomeBloc, HomeState>(
    'given snackbar displayed event, update state to hide snackbar if the current state is success',
    build: () => homeBloc,
    act: (bloc) => bloc.add(HomeSnackbarDisplayed()),
    seed: () =>
        HomeLoadSuccess(notes: NoteBuilder.buildList(), showSnackbar: true),
    expect: () => [
      HomeLoadSuccess(notes: NoteBuilder.buildList(), showSnackbar: false),
    ],
  );

  blocTest<HomeBloc, HomeState>(
    'given snackbar displayed event, do not update state to hide snackbar if the current state is failure',
    build: () => homeBloc,
    act: (bloc) => bloc.add(HomeSnackbarDisplayed()),
    seed: () => HomeLoadFailure(),
    expect: () => [],
  );
}
