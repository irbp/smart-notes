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
    this.showRemoveNoteDialog = false,
    this.snackbarMessage = '',
  });

  final HomeStatus status;
  final List<Note> notes;
  final bool navigateToCreateNotePage;
  final bool showRemoveNoteDialog;
  final String snackbarMessage;

  HomeState copyWith({
    HomeStatus? status,
    List<Note>? notes,
    bool? navigateToCreateNotePage,
    bool? showRemoveNoteDialog,
    String? snackbarMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      notes: notes ?? this.notes,
      navigateToCreateNotePage:
          navigateToCreateNotePage ?? this.navigateToCreateNotePage,
      showRemoveNoteDialog: showRemoveNoteDialog ?? this.showRemoveNoteDialog,
      snackbarMessage: snackbarMessage ?? this.snackbarMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        notes,
        navigateToCreateNotePage,
        showRemoveNoteDialog,
        snackbarMessage
      ];
}
