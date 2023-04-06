import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../widgets/action_button.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    required this.initialLocation,
  });
  final LatLng initialLocation;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _selectedLatLng = LatLng(123.12, 32.32);

  bool hasSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              onTap: (LatLng latLng) {
                setState(() {
                  _selectedLatLng = latLng;
                  if (!hasSelected) {
                    hasSelected = true;
                  }
                });
              },
              initialCameraPosition: CameraPosition(
                target: widget.initialLocation,
                zoom: 15,
              ),
              markers: _selectedLatLng != null
                  ? {
                      Marker(
                        markerId: MarkerId('selected_marker'),
                        position: _selectedLatLng,
                      ),
                    }
                  : {},
            ),
          ),
          if (hasSelected)
            ActionButton(
                title: "Set Value",
                onPressed: () {
                  print(
                      "We got a value ${_selectedLatLng.latitude} :: ${_selectedLatLng.longitude}");
                  Navigator.pop(context, _selectedLatLng);
                }),
        ],
      ),
    );
  }
}
