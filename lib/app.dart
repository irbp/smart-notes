import 'package:flutter/material.dart';
import 'package:smart_notes/di/setup_di.dart';
import 'package:smart_notes/ui/color_schemes.dart';
import 'package:smart_notes/ui/strings.dart';

import 'feature/note/presentation/view/home_page.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    registerAppDependencies();
  }

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
      home: HomePage(),
    );
  }
}
