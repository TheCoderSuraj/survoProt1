import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../models/location_model.dart';
import '../../server_constant.dart';

class FirebaseLocationApi {
  static void testCall() {
    print("Test call");
    // addLocation(
    //     LocationModel(
    //       lat: 12.21,
    //       lon: 32.32,
    //     ),
    //     "123");
  }

  static void addLocation(
    LocationModel loc,
    String id, {
    Function()? onSuccess,
    Function(String error)? onError,
  }) async {
    try {
      Map<String, dynamic> value = loc.toJson();
      value.remove('time');
      value['time'] = FieldValue.serverTimestamp();
      FirebaseFirestore.instance
          .collection(skAccountCollectionName)
          .doc(id)
          .collection(skLocationCollectionName)
          .doc()
          .set(value);
      if (onSuccess != null) {
        onSuccess();
      }
    } catch (e) {
      debugPrint("Add Location error: $e");
      if (onError != null) {
        onError(e.toString());
      }
    }
  }

  static Future<LocationModel?> getCurrentLocation(
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
          .orderBy('time', descending: true)
          .limit(1)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          loc = LocationModel.fromJson(value.docs[0].data());
          if (onSuccess != null) {
            onSuccess();
          }
        }
        debugPrint("Get location error: null value");
      });
    } catch (e) {
      debugPrint("get location error: $e");
    }
    return loc;
  }

  static Future<Stream<QuerySnapshot<Map<String, dynamic>>>>
      getCurrentLocationSnapshot(String id) async {
    return FirebaseFirestore.instance
        .collection(skAccountCollectionName)
        .doc(id)
        .collection(skLocationCollectionName)
        .limit(1)
        .snapshots();
  }
}
