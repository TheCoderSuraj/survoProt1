import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:survo_protv1/widgets/screen_page_setup.dart';

class SurveillanceScreen extends StatefulWidget {
  const SurveillanceScreen({super.key});

  @override
  State<SurveillanceScreen> createState() => _SurveillanceScreenState();
}

class _SurveillanceScreenState extends State<SurveillanceScreen> {
  // get all users data -> follow for location of each user -> show on live

  void getAllUsersDetails() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Surveillance Screen"),
      ),
      // body: GoogleMap(initialCameraPosition: CameraPosition(target: target))
    );
  }
}
