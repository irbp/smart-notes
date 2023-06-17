part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeLoadInProgress extends HomeState {}

final class HomeLoadSuccess extends HomeState {
  const HomeLoadSuccess({
    this.notes = const [],
    this.showSnackbar = false,
  });

  final List<Note> notes;
  final bool showSnackbar;

  @override
  List<Object> get props => [notes, showSnackbar];

  HomeLoadSuccess copyWith({List<Note>? notes, bool? showSnackbar}) {
    return HomeLoadSuccess(
      notes: notes ?? this.notes,
      showSnackbar: showSnackbar ?? this.showSnackbar,
    );
  }
}

final class HomeLoadFailure extends HomeState {}
