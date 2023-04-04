import 'package:flutter/material.dart';

import 'core/general/screens/home_screen.dart';

void main() {
  runApp(const SurvoProt1App());
}

class SurvoProt1App extends StatelessWidget {
  const SurvoProt1App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
