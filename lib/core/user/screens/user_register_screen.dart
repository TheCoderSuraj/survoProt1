import 'package:flutter/material.dart';
import 'package:survo_protv1/widgets/screen_page_setup.dart';

class UserRegisterScreen extends StatelessWidget {
  const UserRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Register"),
      ),
      body: ScreenPageSetup(
        children: [],
      ),
    );
  }
}
