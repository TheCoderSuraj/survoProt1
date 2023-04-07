import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survo_protv1/core/server/functions/account/account_api.dart';
import 'package:survo_protv1/core/server/functions/location/location_api.dart';
import 'package:survo_protv1/core/superviser/providers/superviser_provider.dart';
import 'package:survo_protv1/core/superviser/screens/add_user_screen.dart';
import 'package:survo_protv1/core/superviser/screens/surveillance_screen.dart';
import 'package:survo_protv1/core/superviser/screens/user_status_screen.dart';
import 'package:survo_protv1/utils/common_methods.dart';
import 'package:survo_protv1/utils/constants.dart';
import 'package:survo_protv1/widgets/action_button.dart';
import 'package:survo_protv1/widgets/screen_page_setup.dart';

import '../../server/models/location_model.dart';
import '../../server/server_constant.dart';

class SuperHomeScreen extends StatelessWidget {
  const SuperHomeScreen({super.key});
  void testListen(String id) {
    FirebaseFirestore.instance
        .collection(skAccountCollectionName)
        .doc(id)
        .collection(skLocationCollectionName)
        .orderBy('time', descending: true)
        .limit(1)
        .snapshots()
        .listen((event) {
      if (event.docs.length > 0) {
        LocationModel lm = LocationModel.fromJson(event.docs[0].data());
        print("lm ${lm.toJson()}");
        // print("lm ${lm.toJson()}");
        showMyToast("location added ${lm.lat}:${lm.lon}");
      } else {
        print("No location data");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("$kAppName Super"),
      ),
      body: ScreenPageSetup(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity),
          // ActionButton(
          //   title: "Test",
          //   onPressed: () {
          //     // AccountApi.testCall();
          //     testListen(context.read<SupervisorProvider>().users[0].id);
          //   },
          // ),
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
          const SizedBox(height: 10),
          ActionButton(
            title: "User Status Screen",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserStatusScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
