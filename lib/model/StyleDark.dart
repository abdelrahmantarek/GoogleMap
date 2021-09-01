

class MapStyle {

  String? elementType;
  List<Stylers>? stylers;

  MapStyle({this.elementType, this.stylers});

  MapStyle.fromJson(Map<String, dynamic> json) {
    elementType = json['elementType'];
    if (json['stylers'] != null) {
      stylers = [];
      json['stylers'].forEach((v) {
        stylers!.add(new Stylers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['elementType'] = this.elementType;
    if (this.stylers != null) {
      data['stylers'] = this.stylers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stylers {
  String? color;

  Stylers({this.color});

  Stylers.fromJson(Map<String, dynamic> json) {
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this.color;
    return data;
  }
}

