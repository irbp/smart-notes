part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  const HomeSuccess({
    this.notes = const [],
    this.showSnackbar = false,
  });

  final List<Note> notes;
  final bool showSnackbar;

  @override
  List<Object> get props => [notes, showSnackbar];

  HomeSuccess copyWith({List<Note>? notes, bool? showSnackbar}) {
    return HomeSuccess(
      notes: notes ?? this.notes,
      showSnackbar: showSnackbar ?? this.showSnackbar,
    );
  }
}

final class HomeFailure extends HomeState {}
