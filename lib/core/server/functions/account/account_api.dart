import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:survo_protv1/core/server/models/account_model.dart';
import 'package:survo_protv1/core/server/models/location_model.dart';
import 'package:survo_protv1/core/server/server_constant.dart';

class AccountApi {
  static void testCall() async {
    print("Test call");
    // bool v = await checkIfAccountExists("123");
    // print("User exists value $v");
    // addAccount(
    //     AccountModel(
    //         id: "123",
    //         name: "name",
    //         baseLocation: LocationModel(lat: 123.232, lon: 21.32),
    //         allowedDistance: 500), onSuccess: () {
    //   print("Account added successfully");
    // });
    // AccountModel? ac = await getAccount("123");
    List<AccountModel> accounts = await getAllAccount();
    print("We got ${accounts.length} users details");
  }

  static void addAccount(
    AccountModel ac, {
    Function()? onSuccess,
    Function(String error)? onError,
  }) async {
    if (!await checkIfAccountExists(ac.id)) {
      try {
        FirebaseFirestore.instance
            .collection(skAccountCollectionName)
            .doc(ac.id)
            .set(ac.toJson());
        if (onSuccess != null) {
          onSuccess();
        }
      } catch (e) {
        debugPrint("Add account error: $e");
        if (onError != null) {
          onError(e.toString());
        }
      }
    } else {
      const error = "Add account error: Account Id already exists";
      debugPrint(error);
      if (onError != null) {
        onError(error);
      }
    }
  }

  static void updateAccount(
    String id,
    Map<String, dynamic> value, {
    Function()? onSuccess,
    Function(String error)? onError,
  }) async {
    if (await checkIfAccountExists(id)) {
      try {
        FirebaseFirestore.instance
            .collection(skAccountCollectionName)
            .doc(id)
            .update(value);
        if (onSuccess != null) {
          onSuccess();
        }
      } catch (e) {
        debugPrint("update account error: $e");
        if (onError != null) {
          onError(e.toString());
        }
      }
    } else {
      const error = "update account error: Account Id does not exist";
      debugPrint(error);
      if (onError != null) {
        onError(error);
      }
    }
  }

  /// also true if error occurred
  static Future<bool> checkIfAccountExists(
    String id, {
    Function()? onSuccess,
    Function(String error)? onError,
  }) async {
    bool exists = true;
    try {
      await FirebaseFirestore.instance
          .collection(skAccountCollectionName)
          .doc(id)
          .get()
          .then((value) {
        exists = value.exists;
      });
      print("Account exists value ==> $exists");
      if (onSuccess != null) {
        onSuccess();
      }
    } catch (e) {
      debugPrint("Account exist Error: $e");
      exists = true;
      if (onError != null) {
        onError(e.toString());
      }
    }
    return exists;
  }

  static Future<AccountModel?> getAccount(
    String id, {
    Function()? onSuccess,
    Function(String error)? onError,
  }) async {
    AccountModel? ac;
    try {
      await FirebaseFirestore.instance
          .collection(skAccountCollectionName)
          .doc(id)
          .get()
          .then((value) {
        print("value data ${value.data()} ${value.exists}");
        if (value.data() != null) {
          ac = AccountModel.fromJson(value.data()!);
          if (onSuccess != null) {
            onSuccess();
          }
        } else {
          const error = "Get account error: null value";
          debugPrint(error);
          if (onError != null) {
            onError(error);
          }
        }
      });
    } catch (e) {
      debugPrint("get account error: $e");
      if (onError != null) {
        onError(e.toString());
      }
    }
    return ac;
  }

  static Future<List<AccountModel>> getAllAccount({
    Function()? onSuccess,
    Function(String error)? onError,
  }) async {
    List<AccountModel> res = [];
    try {
      await FirebaseFirestore.instance
          .collection(skAccountCollectionName)
          .get()
          .then((value) {
        for (var v in value.docs) {
          AccountModel ac = AccountModel.fromJson(v.data());
          res.add(ac);
        }
      });
    } catch (e) {
      debugPrint("get account error: $e");
      if (onError != null) {
        onError(e.toString());
      }
    }
    return res;
  }
}
