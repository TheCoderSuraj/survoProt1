import 'package:survo_protv1/core/server/models/location_model.dart';

class AccountModel {
  AccountModel({
    required this.name,
    required this.baseLocation,
    required this.allowedDistance,
    this.isActive = false,
    this.id = "",
  });
  late String id;
  late String name;
  late LocationModel baseLocation;
  late double allowedDistance;
  late bool isActive;

  AccountModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    baseLocation = LocationModel.fromJson(json['baseLocation']);
    allowedDistance = json['allowedDistance'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['baseLocation'] = baseLocation.toJson();
    data['allowedDistance'] = allowedDistance;
    data['isActive'] = isActive;
    return data;
  }
}



// {
//   "id":"",
//   "name":"",
//   "baseLocation":{
//   "lat":12.23,
//   "lon":23.123,
//   "time":123
// },
// "allowedDistance":123.12
// }