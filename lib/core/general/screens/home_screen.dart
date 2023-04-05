import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survo_protv1/core/general/providers/data_provider.dart';
import 'package:survo_protv1/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bool isOn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User application"),
      ),
      body: kIsSupervisor
          ? const Center(
              child: Text("You are supervisor"),
            )
          : Consumer<DataProvider>(builder: (context, value, child) {
              return Center(
                child: Switch(
                  onChanged: (v) {
                    value.setOnState(v);
                  },
                  value: value.isOn,
                ),
              );
            }),
    );
  }
}
