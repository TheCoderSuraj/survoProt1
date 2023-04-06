import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:survo_protv1/core/general/providers/data_provider.dart';
import 'package:survo_protv1/core/superviser/providers/superviser_provider.dart';
import 'package:survo_protv1/core/superviser/screens/user_details_screen.dart';
import 'package:survo_protv1/widgets/screen_page_setup.dart';

import '../../server/models/location_model.dart';
import '../../server/server_constant.dart';

class SurveillanceScreen extends StatefulWidget {
  const SurveillanceScreen({super.key});

  @override
  State<SurveillanceScreen> createState() => _SurveillanceScreenState();
}

class _SurveillanceScreenState extends State<SurveillanceScreen> {
  // get all users data -> follow for location of each user -> show on live

  void getAllUsersDetails() async {
    for (var u in context.read<SupervisorProvider>().users) {
      testListen(u.id);
    }
  }

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
        context.read<SupervisorProvider>().updateLastLocation(
              id,
              LatLng(lm.lat, lm.lon),
            );
        // print("lm ${lm.toJson()}");
        // showMyToast("location added ${lm.lat}:${lm.lon}");
      } else {
        print("No location data");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getAllUsersDetails();
  }

  Set<Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Surveillance Screen"),
      ),
      body: Consumer<SupervisorProvider>(builder: (context, value, child) {
        markers = {};
        for (var u in value.users) {
          markers.add(
            Marker(
              markerId: MarkerId(u.id),
              position: u.lastLoc ?? LatLng(12.32, 32.32),
              infoWindow: InfoWindow(
                  title: u.id,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserDetailsScreen(am: u)));
                  }),
            ),
          );
        }
        LocationModel l = value.users[0].baseLocation;
        LatLng t = LatLng(l.lat, l.lon);
        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: t,
            // target: LatLng(30.77225658, 76.5727657),
            zoom: 10,
          ),
          markers: markers,
        );
      }),
      // body: GoogleMap(initialCameraPosition: CameraPosition(target: target))
    );
  }
}
