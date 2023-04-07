import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:survo_protv1/core/general/providers/data_provider.dart';
import 'package:survo_protv1/core/server/functions/location/location_api.dart';
import 'package:survo_protv1/core/server/models/account_model.dart';
import 'package:survo_protv1/core/server/models/location_model.dart';
import 'package:survo_protv1/core/superviser/providers/superviser_provider.dart';
import 'package:survo_protv1/core/user/providers/user_provider.dart';
import 'package:survo_protv1/utils/common_methods.dart';
import 'package:survo_protv1/utils/constants.dart';
import 'package:survo_protv1/widgets/action_button.dart';
import 'package:survo_protv1/widgets/input_field.dart';
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
    initialLoc();
  }

  void initialLoc() async {
    Position pos = await getCurrentPosition();
    Future.sync(() {
      print("you should have to do that");
      context.read<UserProvider>().updateDistanceLocalOnly(
            LocationModel(
              lat: pos.latitude,
              lon: pos.longitude,
            ),
          );
    });
  }

  @override
  void dispose() {
    if (timer != null) {
      timer?.cancel();
      timer = null;
    }
    super.dispose();
  }

  Timer? timer;

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

  Widget buildUserLogin() {
    TextEditingController idController = TextEditingController();
    return Column(
      children: [
        InputField(
          controller: idController,
          labelText: "User Id",
          hintText: "Ask for userId from Supervisor",
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 25),
        ActionButton(
          title: "Log In",
          onPressed: () {
            context.read<UserProvider>().getUser(idController.text);
          },
        ),
      ],
    );
  }

  Widget buildUserOptions(UserProvider up) {
    // return Center(
    //   child: ElevatedButton(
    //     child: Text("Get Location"),
    //     onPressed: () async {
    //       Position pos = await getCurrentPosition();
    //       LocationModel cur =
    //           LocationModel(lat: pos.latitude, lon: pos.longitude);
    //       if (await isOutsideAllowedArea(
    //           context.read<DataProvider>().basePoint, cur)) {
    //         print("you are outside");
    //       } else {
    //         print("You are inside ");
    //       }
    //       FirebaseLocationApi.addLocation(cur, "3353", onSuccess: () {
    //         showMyToast("location added");
    //       }, onError: (e) {
    //         showMyToast("error on adding location: $e");
    //       });
    //     },
    //   ),
    // );
    double lat = up.user?.lastLoc?.latitude ?? 0;
    double lon = up.user?.lastLoc?.longitude ?? 0;
    double speed = 10;
    return Column(
      children: [
        const SizedBox(height: 25, width: double.infinity),
        const CircleAvatar(
          child: Icon(
            Icons.perm_identity,
            size: 80,
          ),
          radius: 50,
        ),
        Text(
          up.user!.name,
          style: kTitleTextStyle,
        ),
        Text(
          up.user!.id,
          style: kDefaultTextStyle,
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: double.infinity,
              ),
              Text(
                  "Base==> Lat: ${up.user!.baseLocation.lat} | Lon: ${up.user!.baseLocation.lon}"),
              Text("Allowed Distance ==> ${up.user!.allowedDistance}"),
              if (up.user!.lastLoc != null)
                Text(
                    "Location==> Lat: ${up.user!.lastLoc!.latitude} | Lon: ${up.user!.lastLoc!.longitude}"),
              if (up.user!.lastLoc != null) Text("Distance==> ${up.distance}"),
              if (up.user!.lastLoc != null)
                Text(
                  up.isInside
                      ? "You are inside allowed area."
                      : "You are outside allowed area.",
                  style: kBoldTextStyle.copyWith(
                    color: up.isInside ? Colors.green : Colors.red,
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ActionButton(
                    widthRatio: .4,
                    title: "Server",
                    onPressed: () async {
                      Position pos = await getCurrentPosition();
                      up.addUserLocationServer(
                        LocationModel(
                          lat: pos.latitude,
                          lon: pos.longitude,
                        ),
                      );
                    },
                  ),
                  ActionButton(
                    widthRatio: 0.4,
                    title: "Local",
                    onPressed: () async {
                      Position pos = await getCurrentPosition();
                      up.updateDistanceLocalOnly(
                        LocationModel(
                          lat: pos.latitude,
                          lon: pos.longitude,
                        ),
                      );
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("Sync Server"),
                  Switch(
                      value: up.syncServer,
                      onChanged: (value) {
                        bool t = up.setSyncServer(value);
                        if (value && t) {
                          timer = Timer.periodic(const Duration(seconds: 4),
                              (timer) {
                            print("We got a call ${DateTime.now().second}");
                            up.addUserLocationServer(LocationModel(
                                lat: up.user!.lastLoc!.latitude,
                                lon: up.user!.lastLoc!.longitude));
                          });
                        } else if (!value && t) {
                          timer?.cancel();
                          timer = null;
                        }
                      }),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: Joystick(
                  listener: (v) {
                    lat += speed * v.x * 0.00001;
                    lon += speed * v.y * 0.00001;
                    double d = Geolocator.distanceBetween(
                        up.user!.baseLocation.lat,
                        up.user!.baseLocation.lon,
                        lat,
                        lon);
                    print("joystick: ${v.x}|${v.y}");
                    print("fake pos: $lat || $lon");
                    print("fake distance ==> $d");
                    up.updateDistanceLocalOnly(
                        LocationModel(lat: lat, lon: lon));
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text("$kAppName User"),
          actions: [
            if (value.user != null)
              IconButton(
                onPressed: () {
                  context.read<UserProvider>().logOut();
                },
                icon: const Icon(Icons.logout),
              ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: kPagePadding,
            child: (value.user == null)
                ? buildUserLogin()
                : buildUserOptions(value),
            // : SizedBox(),
          ),
        ),
      ),
    );
  }
}
