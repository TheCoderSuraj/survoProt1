import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:survo_protv1/core/server/models/location_model.dart';
import 'package:survo_protv1/core/server/server_constant.dart';

class TestSurScreen extends StatelessWidget {
  const TestSurScreen({super.key});
  void testListen() {
    FirebaseFirestore.instance
        .collection(skAccountCollectionName)
        .doc('123')
        .collection(skLocationCollectionName)
        .limit(1)
        .snapshots()
        .listen((event) {
      LocationModel lm = LocationModel.fromJson(event.docs[0].data());
      print("lm");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body:
        );
  }
}
