import 'package:flutter/material.dart';

import '../../domain/entity/note.dart';

class NoteDismissibleCardView extends StatelessWidget {
  const NoteDismissibleCardView({
    required this.note,
    required this.onDismissed,
    super.key,
  });

  final Note note;
  final Function() onDismissed;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(note.id.toString()),
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete),
            SizedBox(width: 8.0),
            Text('Remove note'),
          ],
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) {
        onDismissed();
        return Future.value(false);
      },
      child: Card(
        margin: EdgeInsets.zero,
        child: ListTile(
          title: Text(note.title),
          subtitle: Text(note.description),
        ),
      ),
    );
  }
}
