

class Location{
  double? lat;
  double? lng;
  Location();
  Location.fromJson(Map<String,dynamic> json){
    lat = json["lat"];
    lng = json["lng"];
  }
  Map<String,dynamic> toJson(){
    Map<String,dynamic> data = {};
    data["lat"] = lat;
    data["lng"] = lng;
    return data;
  }
}