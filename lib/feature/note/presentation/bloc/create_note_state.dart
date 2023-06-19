part of 'create_note_bloc.dart';

class CreateNoteState extends Equatable {
  const CreateNoteState({
    required this.title,
    required this.description,
    required this.enableSaveButton,
    required this.showLoadingProgress,
    required this.showError,
    required this.navigateUpWithSuccess,
  });

  final String title;
  final String description;
  final bool enableSaveButton;
  final bool showLoadingProgress;
  final bool showError;
  final bool navigateUpWithSuccess;

  CreateNoteState copyWith({
    String? title,
    String? description,
    bool? enableSaveButton,
    bool? showLoadingProgress,
    bool? showError,
    bool? navigateUpWithSuccess,
  }) {
    return CreateNoteState(
      title: title ?? this.title,
      description: description ?? this.description,
      enableSaveButton: enableSaveButton ?? this.enableSaveButton,
      showLoadingProgress: showLoadingProgress ?? this.showLoadingProgress,
      showError: showError ?? this.showError,
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
      showError: false,
      navigateUpWithSuccess: false,
    );
  }

  @override
  List<Object> get props => [
        title,
        description,
        enableSaveButton,
        showLoadingProgress,
        showError,
        navigateUpWithSuccess,
      ];
}
