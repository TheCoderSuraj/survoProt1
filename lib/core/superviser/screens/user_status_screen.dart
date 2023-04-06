import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:survo_protv1/core/server/models/account_model.dart';
import 'package:survo_protv1/core/server/models/location_model.dart';
import 'package:survo_protv1/core/superviser/providers/superviser_provider.dart';
import 'package:survo_protv1/core/superviser/widegets/user_status_element.dart';
import 'package:survo_protv1/utils/constants.dart';
import 'package:survo_protv1/widgets/screen_page_setup.dart';

class UserStatusScreen extends StatefulWidget {
  const UserStatusScreen({super.key});

  @override
  State<UserStatusScreen> createState() => _UserStatusScreenState();
}

class _UserStatusScreenState extends State<UserStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Status"),
      ),
      body: SafeArea(
        child: Padding(
          padding: kPagePadding,
          child: Consumer<SupervisorProvider>(builder: (context, value, child) {
            return ListView.builder(
              itemBuilder: (context, index) =>
                  UserStatusElement(ac: value.users[index]),
              itemCount: value.users.length,
            );
          }),
        ),
      ),
    );
  }
}
