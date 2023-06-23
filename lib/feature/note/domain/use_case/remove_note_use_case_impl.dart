import 'package:multiple_result/multiple_result.dart';
import 'package:smart_notes/core/error/app_error.dart';
import 'package:smart_notes/feature/note/domain/entity/note.dart';
import 'package:smart_notes/feature/note/domain/repository/notes_repository.dart';
import 'package:smart_notes/feature/note/domain/use_case/remove_note_use_case.dart';

class RemoveNoteUseCaseImpl implements RemoveNoteUseCase {
  RemoveNoteUseCaseImpl({required this.notesRepository});

  final NotesRepository notesRepository;

  @override
  Future<Result<void, AppError>> call(Note note) async {
    return await notesRepository.removeNote(note);
  }
}
