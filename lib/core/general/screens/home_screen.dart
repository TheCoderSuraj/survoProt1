import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isOn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User application"),
      ),
      body: Center(
        child: Switch(
          onChanged: (value) {
            setState(() {
              isOn = false;
            });
          },
          value: isOn,
        ),
      ),
    );
  }
}
