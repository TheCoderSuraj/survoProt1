class LocationModel {
  LocationModel({
    required this.lat,
    required this.lon,
    this.time = 0,
  });
  late double lat;
  late double lon;
  late int time;

  LocationModel.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    data['time'] = time;
    return data;
  }
}

// {
//   "lat":12.23,
//   "lon":23.123,
//   "time":123,
// }