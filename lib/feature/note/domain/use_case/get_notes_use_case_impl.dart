import 'package:multiple_result/multiple_result.dart';
import 'package:smart_notes/core/error/app_error.dart';
import 'package:smart_notes/feature/note/domain/entity/note.dart';
import 'package:smart_notes/feature/note/domain/repository/notes_repository.dart';
import 'package:smart_notes/feature/note/domain/use_case/get_notes_use_case.dart';

class GetNotesUseCaseImpl implements GetNotesUseCase {
  GetNotesUseCaseImpl({required NotesRepository notesRepository})
      : _notesRepository = notesRepository;

  final NotesRepository _notesRepository;

  @override
  Stream<List<Note>> call() => _notesRepository.getNotesStream();
}
