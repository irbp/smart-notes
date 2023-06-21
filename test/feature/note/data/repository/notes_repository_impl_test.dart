import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:smart_notes/core/error/app_error.dart';
import 'package:smart_notes/feature/note/data/repository/notes_repository_impl.dart';
import 'package:smart_notes/feature/note/domain/entity/note.dart';

import '../../fake/note_fake.dart';
import '../../mock/notes_local_data_source_mock.dart';
import '../../object_builder/note_builder.dart';

void main() {
  late NotesLocalDataSourceMock notesLocalDataSourceMock;
  late NotesRepositoryImpl notesRepository;

  setUpAll(() {
    registerFallbackValue(NoteFake());
  });

  setUp(() {
    notesLocalDataSourceMock = NotesLocalDataSourceMock();
    notesRepository = NotesRepositoryImpl(
      notesLocalDataSource: notesLocalDataSourceMock,
    );
    when(() => notesLocalDataSourceMock.saveNote(any()))
        .thenAnswer((_) async => '');
    when(() => notesLocalDataSourceMock.getNotesStream()).thenAnswer(
      (_) async* {
        yield NoteBuilder.buildList();
      },
    );
  });

  test('on save note, return success when no error is thrown', () async {
    final expected = Result.success('');
    const note = Note(
      id: 1,
      title: 'Title test',
      description: 'Description test',
    );

    final actual = await notesRepository.saveNote(note);

    expect(actual, equals(expected));
  });

  test('on save note, return failure when a error is thrown', () async {
    final expected = Result.error(GenericError());
    const note = Note(
      id: 1,
      title: 'Title test',
      description: 'Description test',
    );
    when(() => notesLocalDataSourceMock.saveNote(any()))
        .thenThrow(GenericError());

    final actual = await notesRepository.saveNote(note);

    expect(actual, equals(expected));
  });

  test(
      'on get notes, return success with list of notes when no error is thrown',
      () async {
    final expected = NoteBuilder.buildList();

    final actual = notesRepository.getNotesStream();

    expect(actual, emitsInOrder([expected]));
  });
}
