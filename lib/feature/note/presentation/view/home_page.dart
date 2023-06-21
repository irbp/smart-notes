import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_notes/feature/note/navigation/note_navigation.dart';
import 'package:smart_notes/feature/note/presentation/bloc/home_bloc.dart';
import 'package:smart_notes/ui/strings.dart';

import 'home_failure_view.dart';
import 'home_loading_view.dart';
import 'home_success_view.dart';

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
    return BlocListener<HomeBloc, HomeState>(
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
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text(Strings.appName),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return switch (state.status) {
              HomeStatus.success => HomeSuccessView(state.notes),
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
}
