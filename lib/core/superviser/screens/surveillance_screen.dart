import 'package:flutter/material.dart';
import 'package:survo_protv1/widgets/screen_page_setup.dart';

class SurveillanceScreen extends StatelessWidget {
  const SurveillanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Surveillance Screen"),
      ),
      body: ScreenPageSetup(
        children: [],
      ),
    );
  }
}
