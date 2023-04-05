import 'package:flutter/material.dart';
import 'package:survo_protv1/core/server/functions/account/account_api.dart';
import 'package:survo_protv1/core/server/functions/location/location_api.dart';
import 'package:survo_protv1/core/superviser/screens/add_user_screen.dart';
import 'package:survo_protv1/core/superviser/screens/surveillance_screen.dart';
import 'package:survo_protv1/utils/constants.dart';
import 'package:survo_protv1/widgets/action_button.dart';
import 'package:survo_protv1/widgets/screen_page_setup.dart';

class SuperHomeScreen extends StatelessWidget {
  const SuperHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("$kAppName Super"),
      ),
      body: ScreenPageSetup(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ActionButton(
            title: "Test",
            onPressed: () {
              FirebaseLocationApi.testCall();
            },
          ),
          ActionButton(
            title: "Add user",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddUserScreen(),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          ActionButton(
            title: "Surveillance Screen",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SurveillanceScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
