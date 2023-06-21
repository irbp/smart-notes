import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_notes/core/error/app_error.dart';
import 'package:smart_notes/feature/note/presentation/bloc/home_bloc.dart';

import '../../mock/get_notes_use_case_mock.dart';
import '../../object_builder/note_builder.dart';

void main() {
  late GetNotesUseCaseMock getNotesMock;
  late HomeBloc homeBloc;

  setUp(() {
    getNotesMock = GetNotesUseCaseMock();
    homeBloc = HomeBloc(getNotes: getNotesMock);
    when(() => getNotesMock()).thenAnswer((_) async* {
      yield NoteBuilder.buildList();
    });
  });

  test('initial state should be initial', () {
    const expected = HomeState();

    final actual = homeBloc.state;
    expect(actual, equals(expected));
  });

  blocTest(
    'given init screen event, update state to succes if the notes is loaded with success',
    build: () => homeBloc,
    act: (bloc) => bloc.add(HomeInitScreen()),
    expect: () => [
      const HomeState(status: HomeStatus.loading),
      HomeState(
        status: HomeStatus.success,
        notes: NoteBuilder.buildList(),
      ),
    ],
  );

  blocTest(
    'given init screen event, update state to failure if the notes is not loaded with success',
    build: () => homeBloc,
    setUp: () {
      when(() => getNotesMock()).thenAnswer((_) async* {
        throw GenericError();
      });
    },
    act: (bloc) => bloc.add(HomeInitScreen()),
    expect: () => [
      const HomeState(status: HomeStatus.loading),
      const HomeState(status: HomeStatus.failure),
    ],
  );

  blocTest<HomeBloc, HomeState>(
    'given add button pressed event, update state to navigate to create note page if the current status is success',
    build: () => homeBloc,
    act: (bloc) => bloc.add(HomeAddButtonPressed()),
    seed: () => HomeState(
      status: HomeStatus.success,
      notes: NoteBuilder.buildList(),
    ),
    expect: () => [
      HomeState(
        status: HomeStatus.success,
        notes: NoteBuilder.buildList(),
        navigateToCreateNotePage: true,
      ),
    ],
  );

  blocTest<HomeBloc, HomeState>(
    'given add button pressed event, do not update state to navigate to create note page if the current status is failure',
    build: () => homeBloc,
    act: (bloc) => bloc.add(HomeAddButtonPressed()),
    seed: () => const HomeState(status: HomeStatus.failure),
    expect: () => [],
  );

  blocTest<HomeBloc, HomeState>(
    'given navigation done event, update state to not navigate to create note page if the current status is success',
    build: () => homeBloc,
    act: (bloc) => bloc.add(HomeNavigationDone()),
    seed: () => HomeState(
      status: HomeStatus.success,
      notes: NoteBuilder.buildList(),
      navigateToCreateNotePage: true,
    ),
    expect: () => [
      HomeState(
        status: HomeStatus.success,
        notes: NoteBuilder.buildList(),
        navigateToCreateNotePage: false,
      ),
    ],
  );

  blocTest<HomeBloc, HomeState>(
    'given navigation done event, do not update state to navigate to create note page if the current status is failure',
    build: () => homeBloc,
    act: (bloc) => bloc.add(HomeNavigationDone()),
    seed: () => const HomeState(status: HomeStatus.failure),
    expect: () => [],
  );
}
