import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_notes/feature/note/domain/use_case/get_notes_use_case_impl.dart';

import '../../mock/notes_repository_mock.dart';
import '../../object_builder/note_builder.dart';

void main() {
  late NotesRepositoryMock notesRepositoryMock;
  late GetNotesUseCaseImpl getNotes;

  setUp(() {
    notesRepositoryMock = NotesRepositoryMock();
    getNotes = GetNotesUseCaseImpl(notesRepository: notesRepositoryMock);
    when(() => notesRepositoryMock.getNotesStream()).thenAnswer((_) async* {
      yield NoteBuilder.buildList();
    });
  });

  test('when get notes, return the list of notes if the repository does',
      () async {
    final expected = NoteBuilder.buildList();

    final actual = getNotes();

    expect(actual, emitsInOrder([expected]));
  });
}
