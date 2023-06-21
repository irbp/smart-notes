import 'package:injectable/injectable.dart';
import 'package:smart_notes/core/presentation/ui_error/error_mapper.dart';
import 'package:smart_notes/feature/note/presentation/mapper/save_note_error_mapper.dart';

@module
abstract class NoteErrorMapperModule {
  ErrorMapper getMapper(SaveNoteErrorMapper saveNoteErrorMapper) {
    return ErrorMapper(domainErrorMapper: saveNoteErrorMapper);
  }
}
