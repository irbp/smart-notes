import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:smart_notes/core/error/app_error.dart';
import 'package:smart_notes/feature/note/domain/entity/note.dart';
import 'package:smart_notes/feature/note/domain/use_case/get_notes_use_case_impl.dart';

import '../../mock/notes_repository_mock.dart';
import '../../object_builder/note_builder.dart';

void main() {
  late NotesRepositoryMock notesRepositoryMock;
  late GetNotesUseCaseImpl getNotes;

  setUp(() {
    notesRepositoryMock = NotesRepositoryMock();
    getNotes = GetNotesUseCaseImpl(notesRepository: notesRepositoryMock);
    when(() => notesRepositoryMock.getNotes())
        .thenAnswer((_) async => Result.success(NoteBuilder.buildList()));
  });

  test('when get notes, return the list of notes if the repository does',
      () async {
    final expected = Result.success(NoteBuilder.buildList());

    final actual = await getNotes();

    expect(actual, equals(expected));
  });

  test('when get notes, return a failure if the repository does', () async {
    final Result<List<Note>, AppError> expected = Result.error(GenericError());
    when(() => notesRepositoryMock.getNotes())
        .thenAnswer((_) async => expected);

    final actual = await getNotes();

    expect(actual, equals(expected));
  });
}
