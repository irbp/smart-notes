import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:smart_notes/core/error/app_error.dart';
import 'package:smart_notes/feature/note/domain/entity/note.dart';
import 'package:smart_notes/feature/note/domain/error/save_note_error.dart';
import 'package:smart_notes/feature/note/domain/repository/notes_repository.dart';
import 'package:smart_notes/feature/note/domain/use_case/save_note_use_case.dart';

@Injectable(as: SaveNoteUseCase)
class SaveNoteUseCaseImpl implements SaveNoteUseCase {
  SaveNoteUseCaseImpl({required NotesRepository notesRepository})
      : _notesRepository = notesRepository;

  static const _maxTitleLength = 100;
  static const _maxDescriptionLength = 1000;

  final NotesRepository _notesRepository;

  @override
  Future<Result<void, AppError>> call(NoteParams params) async {
    if (params.title.isEmpty) {
      return Result.error(EmptyTitleError());
    }

    if (params.title.length > _maxTitleLength) {
      return Result.error(TooLongTitleError());
    }

    if (params.description.isEmpty) {
      return Result.error(EmptyDescriptionError());
    }

    if (params.description.length > _maxDescriptionLength) {
      return Result.error(TooLongDescriptionError());
    }

    final note = Note(
      id: DateTime.now().millisecondsSinceEpoch,
      title: params.title,
      description: params.description,
    );
    return await _notesRepository.saveNote(note);
  }
}
