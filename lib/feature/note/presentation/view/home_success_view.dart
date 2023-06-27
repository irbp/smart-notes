import 'package:flutter/material.dart';
import 'package:smart_notes/feature/note/presentation/view/note_dismissible_card_view.dart';
import 'package:smart_notes/ui/strings.dart';

import '../../domain/entity/note.dart';

class HomeSuccessView extends StatelessWidget {
  const HomeSuccessView({
    required this.notes,
    required this.onNoteDismissed,
    super.key,
  });

  final List<Note> notes;
  final Function(Note note) onNoteDismissed;

  @override
  Widget build(BuildContext context) {
    if (notes.isEmpty) {
      return Center(
        child: Text(
          Strings.homeEmptyNotesMessage,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    } else {
      return ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return NoteDismissibleCardView(
            note: note,
            onDismissed: () => onNoteDismissed(note),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16.0);
        },
      );
    }
  }
}
