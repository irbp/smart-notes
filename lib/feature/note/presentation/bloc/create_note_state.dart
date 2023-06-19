part of 'create_note_bloc.dart';

class CreateNoteState extends Equatable {
  const CreateNoteState({
    required this.title,
    required this.description,
    required this.enableSaveButton,
    required this.showLoadingProgress,
    required this.showError,
  });

  final String title;
  final String description;
  final bool enableSaveButton;
  final bool showLoadingProgress;
  final bool showError;

  CreateNoteState copyWith({
    String? title,
    String? description,
    bool? enableSaveButton,
    bool? showLoadingProgress,
    bool? showError,
  }) {
    return CreateNoteState(
      title: title ?? this.title,
      description: description ?? this.description,
      enableSaveButton: enableSaveButton ?? this.enableSaveButton,
      showLoadingProgress: showLoadingProgress ?? this.showLoadingProgress,
      showError: showError ?? this.showError,
    );
  }

  static CreateNoteState initialState() {
    return const CreateNoteState(
      title: '',
      description: '',
      enableSaveButton: false,
      showLoadingProgress: false,
      showError: false,
    );
  }

  @override
  List<Object> get props => [
        title,
        description,
        enableSaveButton,
        showLoadingProgress,
        showError,
      ];
}
