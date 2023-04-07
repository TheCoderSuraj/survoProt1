import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:survo_protv1/core/server/functions/account/account_api.dart';
import 'package:survo_protv1/core/server/functions/location/location_api.dart';
import 'package:survo_protv1/core/server/models/account_model.dart';
import 'package:survo_protv1/core/server/models/location_model.dart';
import 'package:survo_protv1/utils/common_methods.dart';

class UserProvider extends ChangeNotifier {
  AccountModel? _user;
  AccountModel? get user => _user;
  double distance = 0;
  bool isInside = false;
  bool _syncServer = false;
  bool get syncServer => _syncServer;
  LocationModel? _serverLoc;

  bool setSyncServer(bool value) {
    if (value == _syncServer) {
      return false;
    }
    _syncServer = value;
    notifyListeners();
    return true;
  }

  void logOut() async {
    if (_user == null) {
      print("Null User");
      return;
    }

    if (await updateUserStatus(false)) {
      _user = null;
      isInside = false;
      distance = 0;
      _syncServer = false;
      showMyToast("User logged out");
      notifyListeners();
    } else {
      showMyToast("Unexpected Error occurred ", isError: true);
    }
  }

  Future<bool> getUser(String id) async {
    _user = await AccountApi.getAccount(id, onError: (e) {
      showMyToast("Error on getting User: $e", isError: true);
    });
    if (_user == null) return false;
    AccountApi.updateAccount(
      _user!.id,
      {'isActive': true},
      onError: (error) {
        showMyToast("Error on Updating status: $error", isError: true);
        _user = null;
        _syncServer = false;
      },
    );
    notifyListeners();
    return true;
  }

  Future<bool> updateUserStatus(bool value) async {
    if (_user == null) {
      print("Null User");
      return false;
    }
    bool res = false;
    await AccountApi.updateAccount(_user!.id, {'isActive': value},
        onSuccess: () {
      _user?.isActive = value;
      notifyListeners();
      showMyToast("User Status Changed to $value");
      res = true;
    }, onError: (e) {
      showMyToast("Error on changing status: $e", isError: true);
      res = false;
    });
    return res;
  }

  void updateDistanceLocalOnly(LocationModel loc) {
    _user?.lastLoc = LatLng(loc.lat, loc.lon);
    print("gps location is ${loc.lat} | ${loc.lat}");
    print(
        "base location is ${user!.baseLocation.lat} | ${user!.baseLocation.lat}");
    distance = Geolocator.distanceBetween(
        _user!.baseLocation.lat, _user!.baseLocation.lon, loc.lat, loc.lon);
    print("distance is $distance");
    if (distance <= _user!.allowedDistance) {
      isInside = true;
    } else {
      isInside = false;
    }
    notifyListeners();
  }

  void addUserLocationServer(LocationModel loc) {
    if (_user == null) {
      print("Null User");
      return;
    }

    updateDistanceLocalOnly(loc);

    if (_serverLoc?.lat == loc.lat && _serverLoc?.lon == loc.lon) {
      showMyToast("same location");
      // we skipped this entry because location coordinate is same
      // ik time is different but there is logic to automatically create entry with increasing time if all entries are required with specific time gap
      // this will reduce server load
      return;
    }
    FirebaseLocationApi.addLocation(
      loc,
      _user!.id,
      onSuccess: () {
        showMyToast("location added");
        debugPrint("Location added");
        _serverLoc = loc;
      },
      onError: (e) {
        debugPrint("Error on adding location: $e");
      },
    );
  }
}
