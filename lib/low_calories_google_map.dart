import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:low_calories_google_map/Helper/GoogleMapHelper.dart';
import 'package:low_calories_google_map/Widget/PopAskOpenGpsIos.dart';
import 'package:low_calories_google_map/model/Locaiton.dart';
import 'package:low_calories_google_map/model/Marker.dart';
import 'package:low_calories_google_map/model/StyleColor.dart';
export 'package:low_calories_google_map/model/StyleColor.dart';
import 'package:low_calories_google_map/model/Styles.dart';
export 'package:low_calories_google_map/model/Marker.dart';
export 'package:low_calories_google_map/model/ScaleMarkerAnimation.dart';
export 'package:low_calories_google_map/model/Locaiton.dart';
export 'package:low_calories_google_map/model/Polyline.dart';
export 'package:low_calories_google_map/Helper/GoogleMapHelper.dart';
export 'package:low_calories_google_map/GoogleMapView.dart';
export 'package:low_calories_google_map/Controllers/GoogleMapController.dart';










List<Location>? routeExample1 = decodePolyLineLocation("ionvD{pw}DeBWFj@Jz@MDsDnAsBv@_@LSo@m@oBg@gBaFiQuAaFeAgDy@uDmFyQQcAAg@?k@[{Be@iBSw@fAHvDP`CN|@@");








List<Location>? routeExample2 = decodePolyLineLocation("ionvD{pw}DeBWFj@Jz@MDsDnAsBv@_@LSo@m@oBg@gBaFiQuAaFeAgDy@uDmFyQQcAAg@?k@[{Be@iBSw@fAHvDP`CN|@@");


/*
{
    "geocoded_waypoints": [
        {
            "geocoder_status": "OK",
            "place_id": "ChIJjUEvXoRAWBQRbtK-dzwMGzs",
            "types": [
                "premise"
            ]
        },
        {
            "geocoder_status": "OK",
            "place_id": "ChIJcc6DY38_WBQRvD8T0APsXMk",
            "types": [
                "premise"
            ]
        }
    ],
    "routes": [
        {
            "bounds": {
                "northeast": {
                    "lat": 30.0686963,
                    "lng": 31.2664901
                },
                "southwest": {
                    "lat": 30.0621327,
                    "lng": 31.2541552
                }
            },
            "copyrights": "Map data ©2021",
            "legs": [
                {
                    "distance": {
                        "text": "1.9 km",
                        "value": 1853
                    },
                    "duration": {
                        "text": "6 mins",
                        "value": 385
                    },
                    "end_address": "37 Emtedad Mahmoud Fahmi Al Meaamari, Ghamrah, Daher, Cairo Governorate, Egypt",
                    "end_location": {
                        "lat": 30.0664635,
                        "lng": 31.2662604
                    },
                    "start_address": "5 Haret Bostan Al Tag, El-Zaher, Daher, Cairo Governorate, Egypt",
                    "start_location": {
                        "lat": 30.0621327,
                        "lng": 31.255343
                    },
                    "steps": [
                        {
                            "distance": {
                                "text": "57 m",
                                "value": 57
                            },
                            "duration": {
                                "text": "1 min",
                                "value": 12
                            },
                            "end_location": {
                                "lat": 30.0626356,
                                "lng": 31.2554645
                            },
                            "html_instructions": "Head <b>north</b> on <b>Haret Bostan Al Tag</b> toward <b>El-Zaher</b>",
                            "polyline": {
                                "points": "ionvD{pw}DeBW"
                            },
                            "start_location": {
                                "lat": 30.0621327,
                                "lng": 31.255343
                            },
                            "travel_mode": "DRIVING"
                        },
                        {
                            "distance": {
                                "text": "52 m",
                                "value": 52
                            },
                            "duration": {
                                "text": "1 min",
                                "value": 19
                            },
                            "end_location": {
                                "lat": 30.06254079999999,
                                "lng": 31.2549401
                            },
                            "html_instructions": "Turn <b>left</b> onto <b>El-Zaher</b>",
                            "maneuver": "turn-left",
                            "polyline": {
                                "points": "ornvDsqw}DFj@Jz@"
                            },
                            "start_location": {
                                "lat": 30.0626356,
                                "lng": 31.2554645
                            },
                            "travel_mode": "DRIVING"
                        },
                        {
                            "distance": {
                                "text": "0.2 km",
                                "value": 205
                            },
                            "duration": {
                                "text": "1 min",
                                "value": 78
                            },
                            "end_location": {
                                "lat": 30.0642535,
                                "lng": 31.2541552
                            },
                            "html_instructions": "Turn <b>right</b> onto <b>Ard Al Haramin</b>",
                            "maneuver": "turn-right",
                            "polyline": {
                                "points": "{qnvDknw}DMDqAd@aBh@g@TkA`@_@L"
                            },
                            "start_location": {
                                "lat": 30.06254079999999,
                                "lng": 31.2549401
                            },
                            "travel_mode": "DRIVING"
                        },
                        {
                            "distance": {
                                "text": "1.3 km",
                                "value": 1290
                            },
                            "duration": {
                                "text": "3 mins",
                                "value": 166
                            },
                            "end_location": {
                                "lat": 30.0686963,
                                "lng": 31.2664901
                            },
                            "html_instructions": "Turn <b>right</b> onto <b>Ramses</b>",
                            "maneuver": "turn-right",
                            "polyline": {
                                "points": "q|nvDoiw}DSo@Oe@]iAMe@GUEMK]Qo@Qk@Uy@[gAg@iBk@qBYeA]iAg@cBm@}BMg@w@_CIWWmASaACMCI]kAWy@_@uA{@uCm@qBMe@[eAOu@AMAg@?e@?EKaAOy@WcAMe@Sw@"
                            },
                            "start_location": {
                                "lat": 30.0642535,
                                "lng": 31.2541552
                            },
                            "travel_mode": "DRIVING"
                        },
                        {
                            "distance": {
                                "text": "0.2 km",
                                "value": 249
                            },
                            "duration": {
                                "text": "2 mins",
                                "value": 110
                            },
                            "end_location": {
                                "lat": 30.0664635,
                                "lng": 31.2662604
                            },
                            "html_instructions": "Turn <b>right</b> onto <b>Emtedad Mahmoud Fahmi Al Meaamari</b><div style=\"font-size:0.9em\">Destination will be on the left</div>",
                            "maneuver": "turn-right",
                            "polyline": {
                                "points": "kxovDqvy}DfAHbADrBJn@FpAF|@@"
                            },
                            "start_location": {
                                "lat": 30.0686963,
                                "lng": 31.2664901
                            },
                            "travel_mode": "DRIVING"
                        }
                    ],
                    "traffic_speed_entry": [],
                    "via_waypoint": []
                }
            ],
            "overview_polyline": {
                "points": "ionvD{pw}DeBWFj@Jz@MDsDnAsBv@_@LSo@m@oBg@gBaFiQuAaFeAgDy@uDmFyQQcAAg@?k@[{Be@iBSw@fAHvDP`CN|@@"
            },
            "summary": "Ramses",
            "warnings": [],
            "waypoint_order": []
        }
    ],
    "status": "OK"
}
 */




