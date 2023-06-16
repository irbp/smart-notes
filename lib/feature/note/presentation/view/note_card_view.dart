import 'package:flutter/material.dart';

import '../../domain/entity/note.dart';

class NoteCardView extends StatelessWidget {
  const NoteCardView(this.note, {super.key});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(note.title),
        subtitle: Text(note.description),
      ),
    );
  }
}
