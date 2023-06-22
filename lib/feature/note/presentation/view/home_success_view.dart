import 'package:flutter/material.dart';
import 'package:smart_notes/feature/note/presentation/view/note_card_view.dart';

import '../../domain/entity/note.dart';

class HomeSuccessView extends StatelessWidget {
  const HomeSuccessView(this.notes, {super.key});

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    if (notes.isEmpty) {
      return Center(
        child: Text(
          'Nothing to see here.\nBegin by adding a new note!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    } else {
      return ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return NoteCardView(notes[index]);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 8.0);
        },
      );
    }
  }
}
