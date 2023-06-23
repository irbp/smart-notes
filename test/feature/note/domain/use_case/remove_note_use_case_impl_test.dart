import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:smart_notes/core/error/app_error.dart';
import 'package:smart_notes/feature/note/domain/use_case/remove_note_use_case_impl.dart';

import '../../fake/note_fake.dart';
import '../../mock/notes_repository_mock.dart';
import '../../object_builder/note_builder.dart';

void main() {
  late NotesRepositoryMock notesRepositoryMock;
  late RemoveNoteUseCaseImpl removeNote;

  setUpAll(() {
    registerFallbackValue(NoteFake());
  });

  setUp(() {
    notesRepositoryMock = NotesRepositoryMock();
    removeNote = RemoveNoteUseCaseImpl(notesRepository: notesRepositoryMock);
    when(() => notesRepositoryMock.removeNote(any()))
        .thenAnswer((_) async => Result.success(''));
  });

  test(
    'return success if the repository remove note with success',
    () async {
      final expected = Result.success('');

      final actual = await removeNote(NoteBuilder.build());

      expect(actual, equals(expected));
    },
  );

  test(
    'return failure if the repository does not remove note with success',
    () async {
      final Result<void, AppError> expected = Result.error(GenericError());
      when(() => notesRepositoryMock.removeNote(any()))
          .thenAnswer((_) async => expected);

      final actual = await removeNote(NoteBuilder.build());

      expect(actual, equals(expected));
    },
  );
}
