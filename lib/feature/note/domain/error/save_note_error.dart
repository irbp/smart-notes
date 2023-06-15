import 'package:smart_notes/core/error/domain_error.dart';

sealed class SaveNoteError extends DomainError {}

final class EmptyTitleError extends SaveNoteError {}

final class TooLongTitleError extends SaveNoteError {}

final class EmptyDescriptionError extends SaveNoteError {}

final class TooLongDescriptionError extends SaveNoteError {}
