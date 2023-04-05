import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../models/location_model.dart';
import '../../server_constant.dart';

class FirebaseLocationApi {
  void addLocation(
    LocationModel loc,
    String id, {
    Function()? onSuccess,
    Function(String error)? onError,
  }) async {
    try {
      FirebaseFirestore.instance
          .collection(skAccountCollectionName)
          .doc(id)
          .collection(skLocationCollectionName)
          .doc()
          .set(loc.toJson());
      if (onSuccess != null) {
        onSuccess();
      }
    } catch (e) {
      debugPrint("Add account error: $e");
      if (onError != null) {
        onError(e.toString());
      }
    }
  }

  Future<LocationModel?> getCurrentLocation(
    String id, {
    Function()? onSuccess,
    Function(String error)? onError,
  }) async {
    LocationModel? loc;
    try {
      await FirebaseFirestore.instance
          .collection(skAccountCollectionName)
          .doc(id)
          .collection(skLocationCollectionName)
          .limit(1)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          loc = LocationModel.fromJson(value.docs[0].data());
          if (onSuccess != null) {
            onSuccess();
          }
        }
        debugPrint("Get account error: null value");
      });
    } catch (e) {
      debugPrint("get account error: $e");
    }
    return loc;
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>>
      getCurrentLocationSnapshot(String id) async {
    return FirebaseFirestore.instance
        .collection(skAccountCollectionName)
        .doc(id)
        .collection(skLocationCollectionName)
        .limit(1)
        .snapshots();
  }
}
