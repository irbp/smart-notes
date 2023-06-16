import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_notes/feature/note/data/data_source/notes_local_data_source_in_memory.dart';
import 'package:smart_notes/feature/note/data/repository/notes_repository_impl.dart';
import 'package:smart_notes/feature/note/domain/use_case/get_notes_use_case_impl.dart';
import 'package:smart_notes/feature/note/presentation/bloc/home_bloc.dart';
import 'package:smart_notes/ui/strings.dart';

import 'home_failure_view.dart';
import 'home_loading_view.dart';
import 'home_success_view.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final homeBloc = HomeBloc(
    GetNotesUseCaseImpl(
      notesRepository: NotesRepositoryImpl(
        notesLocalDataSource: NotesLocalDataSourceInMemory(),
      ),
    ),
  )..add(InitScreen());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeBloc,
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(Strings.appName),
      ),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeSuccess && state.showSnackbar) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Clicou no botão'),
              ),
            );
            homeBloc.add(SnackbarDisplayed());
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return switch (state) {
              HomeLoading() => const HomeLoadingView(),
              HomeSuccess() => HomeSuccessView(state.notes),
              HomeFailure() => const HomeFailureView()
            };
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => homeBloc.add(ClickOnAddButton()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
