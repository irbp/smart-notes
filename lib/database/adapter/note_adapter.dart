import 'package:hive/hive.dart';
import 'package:smart_notes/feature/note/domain/entity/note.dart';

class NoteAdapter extends TypeAdapter<Note> {
  @override
  int get typeId => 0;

  @override
  Note read(BinaryReader reader) {
    return Note(
      id: reader.readInt(),
      title: reader.readString(),
      description: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Note obj) {
    writer.writeInt(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.description);
  }
}
