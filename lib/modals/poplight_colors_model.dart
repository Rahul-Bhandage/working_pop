import 'dart:convert';

PopLightColorModel popLightModelFromJson(String str) => PopLightColorModel.fromJson(json.decode(str));

String popLightColorModelToJson(PopLightColorModel data) => json.encode(data.toJson());

class PopLightColorModel {
  String popLightColorId;
  String poplightImagePath;

  PopLightColorModel({
    required this.popLightColorId,
    required this.poplightImagePath,

  });

  factory PopLightColorModel.fromJson(Map<String, dynamic> json) => PopLightColorModel(
    popLightColorId: json["popLightColorId"],
    poplightImagePath: json["poplightImagePath"],

  );

  Map<String, dynamic> toJson() => {
    "popLightColorId": popLightColorId,
    "poplightImagePath": poplightImagePath,

  };
}