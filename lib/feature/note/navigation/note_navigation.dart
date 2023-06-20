import 'package:flutter/widgets.dart';
import 'package:smart_notes/feature/note/presentation/view/create_note_page.dart';
import 'package:smart_notes/feature/note/presentation/view/home_page.dart';

class NoteNavigation {
  static const homeRoute = '/';
  static const createNoteRoute = '/create';
  static const initialRoute = homeRoute;

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      homeRoute: (context) => HomePage(),
      createNoteRoute: (context) => CreateNotePage()
    };
  }
}
