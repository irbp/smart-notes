import 'package:flutter/material.dart';
import 'package:smart_notes/di/setup_di.dart';

import 'app.dart';

void main() async {
  await registerAppDependencies();
  runApp(const MyApp());
}
