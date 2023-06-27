import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_notes/feature/note/navigation/note_navigation.dart';
import 'package:smart_notes/feature/note/presentation/bloc/home_bloc.dart';
import 'package:smart_notes/ui/strings.dart';

import '../view/home_failure_view.dart';
import '../view/home_loading_view.dart';
import '../view/home_success_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<HomeBloc>()..add(HomeInitScreen()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeBloc, HomeState>(
          listenWhen: (previous, current) {
            return previous.navigateToCreateNotePage !=
                current.navigateToCreateNotePage;
          },
          listener: (context, state) {
            if (state.navigateToCreateNotePage) {
              Navigator.of(context).pushNamed(NoteNavigation.createNoteRoute);
              homeBloc.add(HomeNavigationDone());
            }
          },
        ),
        BlocListener<HomeBloc, HomeState>(
          listenWhen: (previous, current) {
            return previous.snackbarMessage != current.snackbarMessage;
          },
          listener: (context, state) {
            if (state.snackbarMessage.isNotEmpty) {
              _showSnackbar(context, state.snackbarMessage);
              homeBloc.add(HomeSnackbarDisplayed());
            }
          },
        ),
        BlocListener<HomeBloc, HomeState>(
          listenWhen: (previous, current) {
            return previous.showRemoveNoteDialog !=
                current.showRemoveNoteDialog;
          },
          listener: (context, state) {
            if (state.showRemoveNoteDialog) {
              _showRemoveNoteDialog(context, homeBloc);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text(Strings.appName),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return switch (state.status) {
              HomeStatus.success => HomeSuccessView(
                  notes: state.notes,
                  onNoteDismissed: (note) {
                    homeBloc.add(HomeDismissNoteCard(note: note));
                  },
                ),
              HomeStatus.failure => const HomeFailureView(),
              _ => const HomeLoadingView()
            };
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => homeBloc.add(HomeAddButtonPressed()),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
  }

  void _showRemoveNoteDialog(BuildContext context, HomeBloc homeBloc) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(Strings.homeRemoveNoteDialogTitle),
        content: const Text(Strings.homeRemoveNoteDialogMessage),
        actions: [
          TextButton(
            onPressed: () {
              homeBloc.add(HomeRemoveNoteDialogCancelPressed());
              Navigator.pop(context);
            },
            child: const Text(Strings.homeRemoveNoteDialogNegativeButton),
          ),
          TextButton(
            onPressed: () {
              homeBloc.add(HomeRemoveNoteDialogRemovePressed());
              Navigator.pop(context);
            },
            child: const Text(Strings.homeRemoveNoteDialogPositiveButton),
          )
        ],
      ),
    );
  }
}
