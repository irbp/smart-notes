part of 'create_note_bloc.dart';

sealed class CreateNoteEvent extends Equatable {
  const CreateNoteEvent();

  @override
  List<Object> get props => [];
}

final class CreateNoteTitleChanged extends CreateNoteEvent {
  const CreateNoteTitleChanged(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

final class CreateNoteDescriptionChanged extends CreateNoteEvent {
  const CreateNoteDescriptionChanged(this.description);

  final String description;

  @override
  List<Object> get props => [description];
}

final class CreateNoteButtonPressed extends CreateNoteEvent {}
