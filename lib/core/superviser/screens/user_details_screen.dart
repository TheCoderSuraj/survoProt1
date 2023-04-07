import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:survo_protv1/core/server/functions/location/location_api.dart';
import 'package:survo_protv1/core/server/models/account_model.dart';
import 'package:survo_protv1/core/server/models/location_model.dart';
import 'package:survo_protv1/utils/constants.dart';
import 'package:survo_protv1/widgets/screen_page_setup.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({
    super.key,
    required this.am,
  });
  final AccountModel am;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  double dist = 0;
  late AccountModel am;

  @override
  void initState() {
    am = widget.am;
    getData();
    super.initState();
  }

  void getData() async {
    LocationModel? lm =
        await FirebaseLocationApi.getCurrentLocation(widget.am.id);
    if (lm == null) {
      return;
    }
    am.lastLoc = LatLng(lm.lat, lm.lon);
    dist = await Geolocator.distanceBetween(
      am.baseLocation.lat,
      am.baseLocation.lon,
      am.lastLoc!.latitude,
      am.lastLoc!.longitude,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.am.name),
      ),
      body: ScreenPageSetup(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity),
          CircleAvatar(
            child: Icon(
              Icons.perm_identity,
              size: 80,
            ),
            radius: 50,
          ),
          Text(
            widget.am.name,
            style: kTitleTextStyle,
          ),
          Text(
            widget.am.id,
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
                Text(widget.am.isActive ? "===ONLINE===" : "===OFFLINE==="),
                Text(
                    "Base==> Lat: ${widget.am.baseLocation.lat} | Lon: ${widget.am.baseLocation.lon}"),
                Text("Allowed Distance ==> ${widget.am.allowedDistance}"),
                if (widget.am.lastLoc != null)
                  Text(
                      "Location==> Lat: ${widget.am.lastLoc!.latitude} | Lon: ${widget.am.lastLoc!.longitude}"),
                if (widget.am.lastLoc != null) Text("Distance==> $dist"),
                if (widget.am.lastLoc != null)
                  Text(
                    !widget.am.isActive
                        ? "He is OFFLINE."
                        : (dist <= widget.am.allowedDistance)
                            ? "He is inside allowed area."
                            : "He is outside allowed area.",
                    style: kBoldTextStyle.copyWith(
                      color: !widget.am.isActive
                          ? Colors.blue
                          : (dist <= widget.am.allowedDistance)
                              ? Colors.green
                              : Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
