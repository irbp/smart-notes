import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_notes/feature/note/domain/use_case/get_notes_use_case.dart';

import '../../domain/entity/note.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetNotesUseCase _getNotes;

  HomeBloc(this._getNotes) : super(HomeLoading()) {
    on<InitScreen>(_handleInitScreen);
    on<ClickOnAddButton>(_handleClickOnAddButton);
    on<SnackbarDisplayed>(_handleSnackbarDisplayed);
  }

  void _handleInitScreen(InitScreen event, Emitter<HomeState> emit) async {
    await _getNotes()
      ..whenSuccess((success) => emit(HomeSuccess(notes: success)))
      ..whenError((error) => emit(HomeFailure()));
  }

  void _handleClickOnAddButton(
    ClickOnAddButton event,
    Emitter<HomeState> emit,
  ) {
    if (state is! HomeSuccess) {
      return;
    }
    emit((state as HomeSuccess).copyWith(showSnackbar: true));
  }

  void _handleSnackbarDisplayed(
    SnackbarDisplayed event,
    Emitter<HomeState> emit,
  ) {
    if (state is! HomeSuccess) {
      return;
    }
    emit((state as HomeSuccess).copyWith(showSnackbar: false));
  }
}
