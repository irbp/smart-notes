import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:smart_notes/core/error/app_error.dart';
import 'package:smart_notes/feature/note/domain/error/save_note_error.dart';
import 'package:smart_notes/feature/note/domain/use_case/save_note_use_case.dart';
import 'package:smart_notes/feature/note/domain/use_case/save_note_use_case_impl.dart';

import '../../fake/note_fake.dart';
import '../../mock/notes_repository_mock.dart';

void main() {
  late NotesRepositoryMock notesRepositoryMock;
  late SaveNoteUseCaseImpl saveNote;

  setUpAll(() {
    registerFallbackValue(NoteFake());
  });

  setUp(() {
    notesRepositoryMock = NotesRepositoryMock();
    saveNote = SaveNoteUseCaseImpl(notesRepository: notesRepositoryMock);
    when(() => notesRepositoryMock.saveNote(any()))
        .thenAnswer((_) async => Result.success(''));
  });

  test('given an empty title, return an empty title error', () async {
    final Result expected = Result.error(EmptyTitleError());
    const params = NoteParams(
      title: '',
      description: 'Test description',
    );

    final actual = await saveNote(params);

    expect(actual, equals(expected));
  });

  test(
      'given a title that exceeds 100 characters, return a too long title error',
      () async {
    final Result expected = Result.error(TooLongTitleError());
    final params = NoteParams(
      title: 'T' * 101,
      description: 'Test description',
    );

    final actual = await saveNote(params);

    expect(actual, equals(expected));
  });

  test('given an empty description, return an empty description error',
      () async {
    final Result expected = Result.error(EmptyDescriptionError());
    const params = NoteParams(
      title: 'Test title',
      description: '',
    );

    final actual = await saveNote(params);

    expect(actual, equals(expected));
  });

  test(
      'given a description that exceeds 1000 characters, return a too long description error',
      () async {
    final Result expected = Result.error(TooLongDescriptionError());
    final params = NoteParams(
      title: 'Test title',
      description: 'T' * 1001,
    );

    final actual = await saveNote(params);

    expect(actual, equals(expected));
  });

  test('given valid parameters, return an error if the repository does',
      () async {
    final Result<void, AppError> expected = Result.error(GenericError());
    const params = NoteParams(
      title: 'Test title',
      description: 'Test description',
    );
    when(() => notesRepositoryMock.saveNote(any()))
        .thenAnswer((_) async => expected);

    final actual = await saveNote(params);

    expect(actual, equals(expected));
  });

  test('given valid parameters, return a success if the repository does',
      () async {
    final expected = Result.success('');
    const params = NoteParams(
      title: 'Test title',
      description: 'Test description',
    );

    final actual = await saveNote(params);

    expect(actual, equals(expected));
  });
}
