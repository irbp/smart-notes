import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_notes/feature/note/domain/use_case/get_notes_use_case.dart';

import '../../domain/entity/note.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetNotesUseCase _getNotes;

  HomeBloc({required GetNotesUseCase getNotes})
      : _getNotes = getNotes,
        super(HomeLoadInProgress()) {
    on<HomeInitScreen>(_handleInitScreen);
    on<HomeAddButtonPressed>(_handleClickOnAddButton);
    on<HomeNavigationDone>(_handleSnackbarDisplayed);
  }

  void _handleInitScreen(HomeInitScreen event, Emitter<HomeState> emit) async {
    await _getNotes()
      ..whenSuccess((success) => emit(HomeLoadSuccess(notes: success)))
      ..whenError((error) => emit(HomeLoadFailure()));
  }

  void _handleClickOnAddButton(
    HomeAddButtonPressed event,
    Emitter<HomeState> emit,
  ) {
    if (state is! HomeLoadSuccess) {
      return;
    }
    emit((state as HomeLoadSuccess).copyWith(navigateToCreateNotePage: true));
  }

  void _handleSnackbarDisplayed(
    HomeNavigationDone event,
    Emitter<HomeState> emit,
  ) {
    if (state is! HomeLoadSuccess) {
      return;
    }
    emit((state as HomeLoadSuccess).copyWith(navigateToCreateNotePage: false));
  }
}
