import 'package:multiple_result/multiple_result.dart';
import 'package:smart_notes/core/error/app_error.dart';
import 'package:smart_notes/core/util/result_of.dart';
import 'package:smart_notes/feature/note/data/data_source/notes_local_data_source.dart';
import 'package:smart_notes/feature/note/domain/entity/note.dart';
import 'package:smart_notes/feature/note/domain/repository/notes_repository.dart';

class NotesRepositoryImpl implements NotesRepository {
  NotesRepositoryImpl({required NotesLocalDataSource notesLocalDataSource})
      : _notesLocalDataSource = notesLocalDataSource;

  final NotesLocalDataSource _notesLocalDataSource;

  @override
  Future<Result<void, AppError>> saveNote(Note note) async {
    return asyncResultOf(() => _notesLocalDataSource.saveNote(note));
  }

  @override
  Stream<List<Note>> getNotesStream() => _notesLocalDataSource.getNotesStream();

  @override
  Future<Result<void, AppError>> removeNote(Note note) {
    // TODO: implement removeNote
    throw UnimplementedError();
  }
}
