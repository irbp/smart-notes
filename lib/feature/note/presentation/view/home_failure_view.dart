import 'package:flutter/material.dart';
import 'package:smart_notes/ui/strings.dart';

class HomeFailureView extends StatelessWidget {
  const HomeFailureView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        Strings.homeFailure,
        style: TextStyle(fontSize: 24.0),
        textAlign: TextAlign.center,
      ),
    );
  }
}
