import 'package:multiple_result/multiple_result.dart';
import 'package:smart_notes/core/error/app_error.dart';

import '../entity/note.dart';

abstract class NotesRepository {
  Future<Result<void, AppError>> saveNote(Note note);
}
