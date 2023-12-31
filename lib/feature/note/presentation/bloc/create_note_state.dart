part of 'create_note_bloc.dart';

class CreateNoteState extends Equatable {
  const CreateNoteState({
    required this.title,
    required this.description,
    required this.enableSaveButton,
    required this.showLoadingProgress,
    required this.errorMessage,
    required this.navigateUpWithSuccess,
    required this.successMessage,
  });

  final String title;
  final String description;
  final bool enableSaveButton;
  final bool showLoadingProgress;
  final String errorMessage;
  final bool navigateUpWithSuccess;
  final String successMessage;

  CreateNoteState copyWith({
    String? title,
    String? description,
    bool? enableSaveButton,
    bool? showLoadingProgress,
    String? errorMessage,
    bool? navigateUpWithSuccess,
    String? successMessage,
  }) {
    return CreateNoteState(
      title: title ?? this.title,
      description: description ?? this.description,
      enableSaveButton: enableSaveButton ?? this.enableSaveButton,
      showLoadingProgress: showLoadingProgress ?? this.showLoadingProgress,
      errorMessage: errorMessage ?? this.errorMessage,
      navigateUpWithSuccess:
          navigateUpWithSuccess ?? this.navigateUpWithSuccess,
      successMessage: successMessage ?? this.successMessage,
    );
  }

  static CreateNoteState initialState() {
    return const CreateNoteState(
      title: '',
      description: '',
      enableSaveButton: false,
      showLoadingProgress: false,
      errorMessage: '',
      navigateUpWithSuccess: false,
      successMessage: '',
    );
  }

  @override
  List<Object> get props => [
        title,
        description,
        enableSaveButton,
        showLoadingProgress,
        errorMessage,
        navigateUpWithSuccess,
        successMessage,
      ];
}
