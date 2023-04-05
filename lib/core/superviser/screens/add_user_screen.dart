import 'package:flutter/material.dart';
import 'package:survo_protv1/core/server/functions/account/account_api.dart';
import 'package:survo_protv1/core/server/models/account_model.dart';
import 'package:survo_protv1/core/server/models/location_model.dart';
import 'package:survo_protv1/utils/common_methods.dart';
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
      Navigator.pop(context);
    }, onError: (e) {
      showMyToast(e, isError: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User"),
      ),
      body: ScreenPageSetup(
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
          const SizedBox(height: 15),
          InputField(
            labelText: "Allowed Distance",
            controller: _limitDistController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 15),
          ActionButton(title: "Add User", onPressed: addUser),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
