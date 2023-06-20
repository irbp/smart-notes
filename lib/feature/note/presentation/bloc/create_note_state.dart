part of 'create_note_bloc.dart';

class CreateNoteState extends Equatable {
  const CreateNoteState({
    required this.title,
    required this.description,
    required this.enableSaveButton,
    required this.showLoadingProgress,
    required this.error,
    required this.navigateUpWithSuccess,
  });

  final String title;
  final String description;
  final bool enableSaveButton;
  final bool showLoadingProgress;
  final String error;
  final bool navigateUpWithSuccess;

  CreateNoteState copyWith({
    String? title,
    String? description,
    bool? enableSaveButton,
    bool? showLoadingProgress,
    String? error,
    bool? navigateUpWithSuccess,
  }) {
    return CreateNoteState(
      title: title ?? this.title,
      description: description ?? this.description,
      enableSaveButton: enableSaveButton ?? this.enableSaveButton,
      showLoadingProgress: showLoadingProgress ?? this.showLoadingProgress,
      error: error ?? this.error,
      navigateUpWithSuccess:
          navigateUpWithSuccess ?? this.navigateUpWithSuccess,
    );
  }

  static CreateNoteState initialState() {
    return const CreateNoteState(
      title: '',
      description: '',
      enableSaveButton: false,
      showLoadingProgress: false,
      error: '',
      navigateUpWithSuccess: false,
    );
  }

  @override
  List<Object> get props => [
        title,
        description,
        enableSaveButton,
        showLoadingProgress,
        error,
        navigateUpWithSuccess,
      ];
}
