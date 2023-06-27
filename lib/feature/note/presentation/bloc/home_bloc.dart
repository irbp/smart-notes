import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_notes/feature/note/domain/use_case/get_notes_use_case.dart';
import 'package:smart_notes/feature/note/domain/use_case/remove_note_use_case.dart';
import 'package:smart_notes/ui/strings.dart';

import '../../domain/entity/note.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required GetNotesUseCase getNotes,
    required RemoveNoteUseCase removeNote,
  })  : _getNotes = getNotes,
        _removeNote = removeNote,
        super(const HomeState()) {
    on<HomeInitScreen>(_handleInitScreen);
    on<HomeAddButtonPressed>(_handleClickOnAddButton);
    on<HomeNavigationDone>(_handleNavigationDone);
    on<HomeDismissNoteCard>(_handleDismissNoteCard);
    on<HomeRemoveNoteDialogCancelPressed>(_handleRemoveNoteDialogCancelPressed);
    on<HomeRemoveNoteDialogRemovePressed>(_handleRemoveNoteDialogRemovePressed);
    on<HomeSnackbarDisplayed>(_handleSnackbarDisplayed);
  }

  final GetNotesUseCase _getNotes;
  final RemoveNoteUseCase _removeNote;

  Note? _noteToBeRemoved;

  Future<void> _handleInitScreen(
    HomeInitScreen event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    await emit.forEach(
      _getNotes(),
      onData: (notes) {
        return state.copyWith(
          status: HomeStatus.success,
          notes: notes,
        );
      },
      onError: (_, __) => state.copyWith(status: HomeStatus.failure),
    );
  }

  Future<void> _handleClickOnAddButton(
    HomeAddButtonPressed event,
    Emitter<HomeState> emit,
  ) async {
    if (state.status != HomeStatus.success) {
      return;
    }
    emit(state.copyWith(navigateToCreateNotePage: true));
  }

  void _handleNavigationDone(
    HomeNavigationDone event,
    Emitter<HomeState> emit,
  ) {
    if (state.status != HomeStatus.success) {
      return;
    }
    emit(state.copyWith(navigateToCreateNotePage: false));
  }

  void _handleDismissNoteCard(
    HomeDismissNoteCard event,
    Emitter<HomeState> emit,
  ) {
    _noteToBeRemoved = event.note;
    emit(state.copyWith(showRemoveNoteDialog: true));
  }

  void _handleRemoveNoteDialogCancelPressed(
    HomeRemoveNoteDialogCancelPressed event,
    Emitter<HomeState> emit,
  ) {
    _noteToBeRemoved = null;
    emit(state.copyWith(showRemoveNoteDialog: false));
  }

  Future<void> _handleRemoveNoteDialogRemovePressed(
    HomeRemoveNoteDialogRemovePressed event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(showRemoveNoteDialog: false));
    await _removeNote(_noteToBeRemoved!)
      ..whenSuccess((_) {
        emit(state.copyWith(snackbarMessage: Strings.homeNoteRemoved));
      })
      ..whenError((_) {
        emit(state.copyWith(snackbarMessage: Strings.homeRemoveNoteFailed));
      });
    _noteToBeRemoved = null;
  }

  void _handleSnackbarDisplayed(
    HomeSnackbarDisplayed event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(snackbarMessage: ''));
  }
}
