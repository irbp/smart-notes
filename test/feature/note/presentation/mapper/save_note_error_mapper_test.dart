import 'package:flutter_test/flutter_test.dart';
import 'package:smart_notes/feature/note/domain/error/save_note_error.dart';
import 'package:smart_notes/feature/note/presentation/mapper/save_note_error_mapper.dart';
import 'package:smart_notes/ui/strings.dart';

void main() {
  late SaveNoteErrorMapper mapper;

  setUp(() {
    mapper = SaveNoteErrorMapper();
  });

  test(
    'given empty title error, map to the correct string',
    () {
      const expected = Strings.createNoteEmptyTitleError;

      final actual = mapper.fromDomainError(EmptyTitleError());

      expect(actual, equals(expected));
    },
  );

  test(
    'given too long title error, map to the correct string',
    () {
      const expected = Strings.createNoteTooLongTitleError;

      final actual = mapper.fromDomainError(TooLongTitleError());

      expect(actual, equals(expected));
    },
  );

  test(
    'given empty description error, map to the correct string',
    () {
      const expected = Strings.createNoteEmptyDescriptionError;

      final actual = mapper.fromDomainError(EmptyDescriptionError());

      expect(actual, equals(expected));
    },
  );

  test(
    'given too long description error, map to the correct string',
    () {
      const expected = Strings.createNoteTooLongDescriptionError;

      final actual = mapper.fromDomainError(TooLongDescriptionError());

      expect(actual, equals(expected));
    },
  );
}
