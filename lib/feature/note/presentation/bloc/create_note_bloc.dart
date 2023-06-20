import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_notes/core/presentation/ui_error/error_mapper.dart';
import 'package:smart_notes/feature/note/domain/use_case/save_note_use_case.dart';
import 'package:smart_notes/ui/strings.dart';

part 'create_note_event.dart';
part 'create_note_state.dart';

class CreateNoteBloc extends Bloc<CreateNoteEvent, CreateNoteState> {
  final SaveNoteUseCase _saveNote;
  final ErrorMapper _errorMapper;

  CreateNoteBloc({
    required SaveNoteUseCase saveNote,
    required ErrorMapper errorMapper,
  })  : _saveNote = saveNote,
        _errorMapper = errorMapper,
        super(CreateNoteState.initialState()) {
    on<CreateNoteTitleChanged>(_handleTitleChanged);
    on<CreateNoteDescriptionChanged>(_handleDescriptionChanged);
    on<CreateNoteButtonPressed>(_handleCreateNoteButtonPressed);
  }

  void _handleTitleChanged(
    CreateNoteTitleChanged event,
    Emitter<CreateNoteState> emit,
  ) {
    emit(state.copyWith(
      title: event.title,
      enableSaveButton: event.title.isNotEmpty && state.description.isNotEmpty,
      errorMessage: '',
    ));
  }

  void _handleDescriptionChanged(
    CreateNoteDescriptionChanged event,
    Emitter<CreateNoteState> emit,
  ) {
    emit(state.copyWith(
      description: event.description,
      enableSaveButton: event.description.isNotEmpty && state.title.isNotEmpty,
      errorMessage: '',
    ));
  }

  void _handleCreateNoteButtonPressed(
    CreateNoteButtonPressed event,
    Emitter<CreateNoteState> emit,
  ) async {
    emit(state.copyWith(showLoadingProgress: true));
    final noteParams = NoteParams(
      title: state.title,
      description: state.description,
    );
    await _saveNote(noteParams)
      ..whenSuccess(
        (success) => emit(
          state.copyWith(
            showLoadingProgress: false,
            navigateUpWithSuccess: true,
            successMessage: Strings.createNoteSuccess,
          ),
        ),
      )
      ..whenError(
        (error) => emit(
          state.copyWith(
            showLoadingProgress: false,
            errorMessage: _errorMapper.fromAppError(error),
          ),
        ),
      );
  }
}
