import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_notes/feature/note/domain/use_case/get_notes_use_case.dart';

import '../../domain/entity/note.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required GetNotesUseCase getNotes})
      : _getNotes = getNotes,
        super(const HomeState()) {
    on<HomeInitScreen>(_handleInitScreen);
    on<HomeAddButtonPressed>(_handleClickOnAddButton);
    on<HomeNavigationDone>(_handleNavigationDone);
  }

  final GetNotesUseCase _getNotes;

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
}
