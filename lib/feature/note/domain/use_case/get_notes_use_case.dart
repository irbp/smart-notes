import 'package:smart_notes/feature/note/domain/entity/note.dart';

abstract class GetNotesUseCase {
  Stream<List<Note>> call();
}
