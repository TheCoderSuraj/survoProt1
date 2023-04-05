import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:survo_protv1/core/server/models/account_model.dart';
import 'package:survo_protv1/core/server/server_constant.dart';

class AccountApi {
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
        if (value.exists && value.data() != null) {
          ac = AccountModel.fromJson(value.data()!);
          if (onSuccess != null) {
            onSuccess();
          }
        }
        debugPrint("Get account error: null value");
        if (onError != null) {
          onError(e.toString());
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
}
