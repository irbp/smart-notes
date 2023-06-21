part of 'home_bloc.dart';

enum HomeStatus {
  initial,
  loading,
  success,
  failure,
}

final class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.notes = const [],
    this.navigateToCreateNotePage = false,
  });

  final HomeStatus status;
  final List<Note> notes;
  final bool navigateToCreateNotePage;

  HomeState copyWith({
    HomeStatus? status,
    List<Note>? notes,
    bool? navigateToCreateNotePage,
  }) {
    return HomeState(
      status: status ?? this.status,
      notes: notes ?? this.notes,
      navigateToCreateNotePage:
          navigateToCreateNotePage ?? this.navigateToCreateNotePage,
    );
  }

  @override
  List<Object?> get props => [status, notes, navigateToCreateNotePage];
}
