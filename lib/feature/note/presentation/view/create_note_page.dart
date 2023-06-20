import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_notes/feature/note/presentation/bloc/create_note_bloc.dart';

import '../../../../ui/strings.dart';

class CreateNotePage extends StatelessWidget {
  CreateNotePage({super.key});

  final createNoteBloc = GetIt.I<CreateNoteBloc>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => createNoteBloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text(Strings.createNoteTitle),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 24.0,
            horizontal: 16.0,
          ),
          child: CreateNoteForm(),
        ),
      ),
    );
  }
}

class CreateNoteForm extends StatelessWidget {
  const CreateNoteForm({super.key});

  @override
  Widget build(BuildContext context) {
    final createNoteBloc = BlocProvider.of<CreateNoteBloc>(context);
    return BlocListener<CreateNoteBloc, CreateNoteState>(
      listener: (context, state) {
        if (state.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
              ),
            );
        }
        if (state.navigateUpWithSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<CreateNoteBloc, CreateNoteState>(
        builder: (context, state) {
          return Column(
            children: [
              _TitleTextField(
                onChanged: (title) => createNoteBloc.add(
                  CreateNoteTitleChanged(title),
                ),
              ),
              const SizedBox(height: 16.0),
              _DescriptionTextField(
                onChanged: (description) => createNoteBloc.add(
                  CreateNoteDescriptionChanged(description),
                ),
              ),
              const SizedBox(height: 24.0),
              _LoadingProgressButton(
                showLoadingProgress: state.showLoadingProgress,
                onPressed: state.enableSaveButton
                    ? () => createNoteBloc.add(CreateNoteButtonPressed())
                    : null,
                child: const Text(Strings.createNoteButtonSaveNote),
              )
            ],
          );
        },
      ),
    );
  }
}

class _DescriptionTextField extends StatelessWidget {
  const _DescriptionTextField({
    required this.onChanged,
  });

  final Function(String description) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: Strings.createNoteTextFieldDescription,
      ),
      textInputAction: TextInputAction.done,
      maxLength: 1000,
      maxLines: 5,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
    );
  }
}

class _TitleTextField extends StatelessWidget {
  const _TitleTextField({
    required this.onChanged,
  });

  final Function(String title) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: Strings.createNoteTextFieldTitle,
      ),
      textInputAction: TextInputAction.next,
      maxLength: 100,
      keyboardType: TextInputType.text,
      textCapitalization: TextCapitalization.sentences,
    );
  }
}

class _LoadingProgressButton extends StatelessWidget {
  const _LoadingProgressButton({
    required this.showLoadingProgress,
    this.onPressed,
    required this.child,
  });

  final bool showLoadingProgress;
  final Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return showLoadingProgress
        ? const CircularProgressIndicator()
        : ElevatedButton(
            onPressed: onPressed,
            child: child,
          );
  }
}
