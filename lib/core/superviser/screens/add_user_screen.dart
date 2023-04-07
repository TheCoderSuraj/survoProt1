import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:survo_protv1/core/server/functions/account/account_api.dart';
import 'package:survo_protv1/core/server/models/account_model.dart';
import 'package:survo_protv1/core/server/models/location_model.dart';
import 'package:survo_protv1/core/superviser/providers/superviser_provider.dart';
import 'package:survo_protv1/core/superviser/screens/map_screen.dart';
import 'package:survo_protv1/utils/common_methods.dart';
import 'package:survo_protv1/utils/constants.dart';
import 'package:survo_protv1/widgets/action_button.dart';
import 'package:survo_protv1/widgets/input_field.dart';
import 'package:survo_protv1/widgets/screen_page_setup.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _latController = TextEditingController();
  TextEditingController _lonController = TextEditingController();
  TextEditingController _limitDistController = TextEditingController();

  void addUser() {
    double? id = double.tryParse(_idController.text);
    double? lat = double.tryParse(_latController.text);
    double? lon = double.tryParse(_lonController.text);
    double? lim = double.tryParse(_limitDistController.text);

    if (id == null || lat == null || lon == null || lim == null) {
      showMyToast("Error: Invalid Input", isError: true);
      return;
    }
    AccountModel ac = AccountModel(
      id: _idController.text,
      name: _nameController.text,
      baseLocation: LocationModel(lat: lat, lon: lon),
      allowedDistance: lim,
    );

    AccountApi.addAccount(ac, onSuccess: () {
      showMyToast("Account added successfully");
      context.read<SupervisorProvider>().addUser(ac);
      Navigator.pop(context);
    }, onError: (e) {
      showMyToast(e, isError: true);
    });
  }

  void selectLocationFromMap(LatLng loc) async {
    print("call for map location");
    LatLng? t = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => MapScreen(
                  initialLocation: loc,
                )))) as LatLng?;
    if (t != null) {
      setState(() {
        _latController.text = t.latitude.toString();
        _lonController.text = t.longitude.toString();
      });
    }
  }

  Future<LatLng?> askLocation() async {
    LatLng? res;
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
      res = LatLng(curPosition.latitude, curPosition.longitude);
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User"),
      ),
      body: ScreenPageSetup(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InputField(
            labelText: "Id",
            controller: _idController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 15),
          InputField(
            labelText: "Name",
            controller: _nameController,
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 15),
          const Text(
            "Base Location",
            style: kSemiBoldTextStyle,
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: InputField(
                  labelText: "Latitude",
                  controller: _latController,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: InputField(
                  labelText: "Longitude",
                  controller: _lonController,
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ActionButton(
              title: "Select from Map",
              onPressed: () async {
                showMyToast("getting your location for reference...");
                LatLng? l = await askLocation();
                print("location we got $l");
                if (l != null) {
                  selectLocationFromMap(l);
                }
              }),
          const SizedBox(height: 15),
          InputField(
            labelText: "Allowed Distance",
            controller: _limitDistController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 15),
          const Spacer(),
          ActionButton(title: "Add User", onPressed: addUser),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
