import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survo_protv1/core/general/providers/data_provider.dart';
import 'package:survo_protv1/core/superviser/screens/super_home_screen.dart';
import 'package:survo_protv1/utils/constants.dart';
import 'package:survo_protv1/widgets/action_button.dart';
import 'package:survo_protv1/widgets/screen_page_setup.dart';

import '../../user/screens/user_home_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bool isOn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User application"),
      ),
      body: ScreenPageSetup(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity),
          ActionButton(
            title: "Supervisor",
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SuperHomeScreen()));
            },
          ),
          const SizedBox(height: 15),
          ActionButton(
            title: "User",
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserHomeScreen()));
            },
          ),
        ],
      ),
    );
  }
}
