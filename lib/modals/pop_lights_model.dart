// To parse this JSON data, do
//
//     final popLightModel = popLightModelFromJson(jsonString);

import 'dart:convert';

PopLightModel popLightModelFromJson(String str) => PopLightModel.fromJson(json.decode(str));

String popLightModelToJson(PopLightModel data) => json.encode(data.toJson());

class PopLightModel {
  String popLightId;
  int groupId;
  String popLightName;
  int isOn;
  int brightness;
  int glow;
  int timer;
  String colorid;

  PopLightModel({
    required this.popLightId,
    required this.groupId,
    required this.popLightName,
    required this.isOn,
    required this.brightness,
    required this.glow,
    required this.timer,
    required this.colorid,
  });

  factory PopLightModel.fromJson(Map<String, dynamic> json) => PopLightModel(
    popLightId: json["popLightId"],
    groupId: json["groupId"],
    popLightName: json["popLightName"],
    isOn: json["isOn"],
    brightness: json["brightness"],
    glow: json["glow"],
    timer: json["timer"],
    colorid: json["colorid"],
  );

  Map<String, dynamic> toJson() => {
    "popLightId": popLightId,
    "groupId": groupId,
    "popLightName": popLightName,
    "isOn": isOn,
    "brightness": brightness,
    "glow": glow,
    "timer": timer,
    "colorid": colorid,
  };
}
