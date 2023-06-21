import 'package:flutter/material.dart';
import 'package:smart_notes/feature/note/navigation/note_navigation.dart';
import 'package:smart_notes/ui/color_schemes.dart';
import 'package:smart_notes/ui/strings.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      theme: ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: darkColorScheme,
        useMaterial3: true,
      ),
      routes: NoteNavigation.getRoutes(),
      initialRoute: NoteNavigation.initialRoute,
    );
  }
}
