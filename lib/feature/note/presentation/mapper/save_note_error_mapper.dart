import 'package:smart_notes/core/presentation/ui_error/domain_error_mapper.dart';
import 'package:smart_notes/feature/note/domain/error/save_note_error.dart';
import 'package:smart_notes/ui/strings.dart';

class SaveNoteErrorMapper extends DomainErrorMapper<SaveNoteError> {
  @override
  String fromDomainError(SaveNoteError error) {
    return switch (error) {
      EmptyTitleError() => Strings.createNoteEmptyTitleError,
      TooLongTitleError() => Strings.createNoteTooLongTitleError,
      EmptyDescriptionError() => Strings.createNoteEmptyDescriptionError,
      TooLongDescriptionError() => Strings.createNoteTooLongDescriptionError
    };
  }
}
