import 'package:flutter/foundation.dart';
import 'package:survo_protv1/core/server/models/location_model.dart';
import 'package:survo_protv1/utils/constants.dart';

class DataProvider extends ChangeNotifier {
  // bool _isSuperviser = false;
  // bool get isSupervider => _isSuperviser;

  bool _isOn = false;
  bool get isOn => _isOn;

  // to check if we have to send location data to server
  // user is on duty
  bool get shouldSendData => !kIsSupervisor && _isOn;

  LocationModel _basePoint = LocationModel(lat: 30.7665685, lon: 76.5735423);
  LocationModel get basePoint => _basePoint;

  // in meters
  double _allowedDistance = 300;
  double get allowedDistance => _allowedDistance;

  void setOnState(bool value) {
    _isOn = value;
    notifyListeners();
  }
}
