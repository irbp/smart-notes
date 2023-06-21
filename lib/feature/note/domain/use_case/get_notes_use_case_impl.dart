import 'package:injectable/injectable.dart';
import 'package:smart_notes/feature/note/domain/entity/note.dart';
import 'package:smart_notes/feature/note/domain/repository/notes_repository.dart';
import 'package:smart_notes/feature/note/domain/use_case/get_notes_use_case.dart';

@Injectable(as: GetNotesUseCase)
class GetNotesUseCaseImpl implements GetNotesUseCase {
  GetNotesUseCaseImpl({required NotesRepository notesRepository})
      : _notesRepository = notesRepository;

  final NotesRepository _notesRepository;

  @override
  Stream<List<Note>> call() => _notesRepository.getNotesStream();
}
