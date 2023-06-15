import 'package:smart_notes/feature/note/domain/entity/note.dart';

class NoteBuilder {
  static List<Note> buildList() {
    return const [
      Note(
        id: 1,
        title: 'Title Test 1',
        description: 'Description Test 1',
      ),
      Note(
        id: 2,
        title: 'Title Test 2',
        description: 'Description Test 2',
      ),
    ];
  }

  static Note build() {
    return const Note(
      id: 1,
      title: 'Title Test',
      description: 'Description Test',
    );
  }
}
