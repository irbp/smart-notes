import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:smart_notes/core/error/app_error.dart';
import 'package:smart_notes/feature/note/domain/use_case/remove_note_use_case.dart';
import 'package:smart_notes/feature/note/presentation/bloc/home_bloc.dart';
import 'package:smart_notes/ui/strings.dart';

import '../../fake/note_fake.dart';
import '../../mock/get_notes_use_case_mock.dart';
import '../../mock/remove_note_use_case_mock.dart';
import '../../object_builder/note_builder.dart';

void main() {
  late GetNotesUseCaseMock getNotesMock;
  late RemoveNoteUseCase removeNoteMock;
  late HomeBloc homeBloc;

  setUpAll(() {
    registerFallbackValue(NoteFake());
  });

  setUp(() {
    getNotesMock = GetNotesUseCaseMock();
    removeNoteMock = RemoveNoteUseCaseMock();
    homeBloc = HomeBloc(getNotes: getNotesMock, removeNote: removeNoteMock);
    when(() => getNotesMock()).thenAnswer((_) async* {
      yield NoteBuilder.buildList();
    });
    when(() => removeNoteMock(any()))
        .thenAnswer((_) async => Result.success(''));
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

  blocTest(
    'given dismis note card event, update state to show a dialog',
    build: () => homeBloc,
    seed: () => HomeState(
      status: HomeStatus.success,
      notes: NoteBuilder.buildList(),
    ),
    act: (bloc) => bloc.add(HomeDismissNoteCard(note: NoteBuilder.build())),
    expect: () => [
      HomeState(
        status: HomeStatus.success,
        notes: NoteBuilder.buildList(),
        showRemoveNoteDialog: true,
      )
    ],
  );

  blocTest(
    'given remove note dialog cancel button pressed event, update state to dismiss the dialog',
    build: () => homeBloc,
    seed: () => HomeState(
      status: HomeStatus.success,
      notes: NoteBuilder.buildList(),
      showRemoveNoteDialog: true,
    ),
    act: (bloc) => bloc.add(HomeRemoveNoteDialogCancelPressed()),
    expect: () => [
      HomeState(
        status: HomeStatus.success,
        notes: NoteBuilder.buildList(),
        showRemoveNoteDialog: false,
      )
    ],
  );

  blocTest(
    'given remove note dialog remove button pressed event, update state correctly on success',
    build: () => homeBloc,
    seed: () => HomeState(
      status: HomeStatus.success,
      notes: NoteBuilder.buildList(),
      showRemoveNoteDialog: true,
    ),
    act: (bloc) {
      bloc.add(HomeDismissNoteCard(note: NoteBuilder.build()));
      bloc.add(HomeRemoveNoteDialogRemovePressed());
    },
    expect: () => [
      HomeState(
        status: HomeStatus.success,
        notes: NoteBuilder.buildList(),
        showRemoveNoteDialog: false,
      ),
      HomeState(
        status: HomeStatus.success,
        notes: NoteBuilder.buildList(),
        showRemoveNoteDialog: false,
        snackbarMessage: Strings.homeNoteRemoved,
      )
    ],
  );

  blocTest(
    'given remove note dialog remove button pressed event, update state correctly on failure',
    build: () => homeBloc,
    setUp: () {
      when(() => removeNoteMock(any()))
          .thenAnswer((_) async => Result.error(GenericError()));
    },
    seed: () => HomeState(
      status: HomeStatus.success,
      notes: NoteBuilder.buildList(),
      showRemoveNoteDialog: true,
    ),
    act: (bloc) {
      bloc.add(HomeDismissNoteCard(note: NoteBuilder.build()));
      bloc.add(HomeRemoveNoteDialogRemovePressed());
    },
    expect: () => [
      HomeState(
        status: HomeStatus.success,
        notes: NoteBuilder.buildList(),
        showRemoveNoteDialog: false,
      ),
      HomeState(
        status: HomeStatus.success,
        notes: NoteBuilder.buildList(),
        showRemoveNoteDialog: false,
        snackbarMessage: Strings.homeRemoveNoteFailed,
      )
    ],
  );

  blocTest(
    'given snackbar displayed event, update state and reset snackbar message',
    build: () => homeBloc,
    seed: () => HomeState(
      status: HomeStatus.success,
      notes: NoteBuilder.buildList(),
      snackbarMessage: 'Test',
    ),
    act: (bloc) => bloc.add(HomeSnackbarDisplayed()),
    expect: () => [
      HomeState(
        status: HomeStatus.success,
        notes: NoteBuilder.buildList(),
        snackbarMessage: '',
      ),
    ],
  );
}
