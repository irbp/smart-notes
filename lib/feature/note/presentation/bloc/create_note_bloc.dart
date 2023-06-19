import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_notes/feature/note/domain/use_case/save_note_use_case.dart';

part 'create_note_event.dart';
part 'create_note_state.dart';

class CreateNoteBloc extends Bloc<CreateNoteEvent, CreateNoteState> {
  final SaveNoteUseCase _saveNote;

  CreateNoteBloc({required SaveNoteUseCase saveNote})
      : _saveNote = saveNote,
        super(CreateNoteState.initialState()) {
    on<CreateNoteTitleChanged>(_handleTitleChanged);
    on<CreateNoteDescriptionChanged>(_handleDescriptionChanged);
    on<CreateNoteButtonPressed>(_handleCreateNoteButtonPressed);
  }

  void _handleTitleChanged(
    CreateNoteTitleChanged event,
    Emitter<CreateNoteState> emitter,
  ) {
    throw UnimplementedError();
  }

  void _handleDescriptionChanged(
    CreateNoteDescriptionChanged event,
    Emitter<CreateNoteState> emitter,
  ) {
    throw UnimplementedError();
  }

  void _handleCreateNoteButtonPressed(
    CreateNoteButtonPressed event,
    Emitter<CreateNoteState> emitter,
  ) {
    throw UnimplementedError();
  }
}
