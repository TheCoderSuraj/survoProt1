import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:survo_protv1/core/general/providers/data_provider.dart';
import 'package:survo_protv1/core/server/functions/location/location_api.dart';
import 'package:survo_protv1/core/server/models/location_model.dart';
import 'package:survo_protv1/core/superviser/providers/superviser_provider.dart';
import 'package:survo_protv1/utils/common_methods.dart';
import 'package:survo_protv1/utils/constants.dart';
import 'package:survo_protv1/widgets/screen_page_setup.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  void askLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("We need location permission");
      await Geolocator.requestPermission();
    } else {
      Position curPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      print("latitude: ${curPosition.latitude}");
      print("longitude: ${curPosition.longitude}");
    }
  }

  @override
  void initState() {
    super.initState();
    askLocation();
  }

  Future<Position> getCurrentPosition() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  Future<bool> isOutsideAllowedArea(
      LocationModel base, LocationModel cur) async {
    // bool isOutside = true;
    double dist =
        Geolocator.distanceBetween(base.lat, base.lon, cur.lat, cur.lon);
    print("Distance is $dist");
    if (dist <= context.read<DataProvider>().allowedDistance) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$kAppName User"),
      ),
      body: ScreenPageSetup(
        children: [
          Center(
            child: ElevatedButton(
              child: Text("Get Location"),
              onPressed: () async {
                Position pos = await getCurrentPosition();
                LocationModel cur =
                    LocationModel(lat: pos.latitude, lon: pos.longitude);
                if (await isOutsideAllowedArea(
                    context.read<DataProvider>().basePoint, cur)) {
                  print("you are outside");
                } else {
                  print("You are inside ");
                }
                FirebaseLocationApi.addLocation(cur, "3353", onSuccess: () {
                  showMyToast("location added");
                }, onError: (e) {
                  showMyToast("error on adding location: $e");
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
