import 'package:flutter/material.dart';

import '../../../../ui/strings.dart';

class CreateNotePage extends StatelessWidget {
  const CreateNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(Strings.createNoteTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24.0,
          horizontal: 16.0,
        ),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: Strings.createNoteTextFieldTitle,
              ),
              textInputAction: TextInputAction.next,
              maxLength: 100,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16.0),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: Strings.createNoteTextFieldDescription,
              ),
              textInputAction: TextInputAction.done,
              maxLength: 1000,
              maxLines: 5,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () => {},
              child: const Text(Strings.createNoteButtonSaveNote),
            ),
          ],
        ),
      ),
    );
  }
}
