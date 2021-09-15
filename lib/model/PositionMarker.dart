class PositionMarker {
  double? lat;
  double? lng;
  PositionMarker(this.lat, this.lng);

  PositionMarker.fromMap(Map<String,dynamic> data){
    lat = data["lat"];
    lng = data["lng"];
  }

  Map<String, dynamic> toJson() {
    return {
      "position.lat": lat,
      "position.lng": lng,
    };
  }
}
