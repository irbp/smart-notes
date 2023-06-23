import 'package:multiple_result/multiple_result.dart';
import 'package:smart_notes/core/error/app_error.dart';
import 'package:smart_notes/feature/note/domain/entity/note.dart';

abstract class RemoveNoteUseCase {
  Future<Result<void, AppError>> call(Note note);
}
