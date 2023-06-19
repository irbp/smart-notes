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
    this.navigateToCreateNotePage = false,
  });

  final List<Note> notes;
  final bool navigateToCreateNotePage;

  @override
  List<Object> get props => [notes, navigateToCreateNotePage];

  HomeLoadSuccess copyWith({
    List<Note>? notes,
    bool? navigateToCreateNotePage,
  }) {
    return HomeLoadSuccess(
      notes: notes ?? this.notes,
      navigateToCreateNotePage:
          navigateToCreateNotePage ?? this.navigateToCreateNotePage,
    );
  }
}

final class HomeLoadFailure extends HomeState {}
