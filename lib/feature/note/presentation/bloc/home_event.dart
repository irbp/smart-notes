part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class HomeInitScreen extends HomeEvent {}

final class HomeAddButtonPressed extends HomeEvent {}

final class HomeNavigationDone extends HomeEvent {}

final class HomeDismissNoteCard extends HomeEvent {
  const HomeDismissNoteCard({required this.note});

  final Note note;

  @override
  List<Object> get props => [note];
}

final class HomeRemoveNoteDialogCancelPressed extends HomeEvent {}

final class HomeRemoveNoteDialogRemovePressed extends HomeEvent {}

final class HomeSnackbarDisplayed extends HomeEvent {}
