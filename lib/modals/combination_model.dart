import 'dart:convert';

import 'package:pop_lights_app/modals/group_model.dart';
import 'package:pop_lights_app/modals/pop_lights_model.dart';

CombineModel CombineModelFromJson(String str) => CombineModel.fromJson(json.decode(str));

String CombineModelToJson(CombineModel data) => json.encode(data.toJson());

class CombineModel {
  List<PopLightModel> model1;
  List<GroupModel>  model2;
  int length_of_model1;
  int length_of_model2;
  CombineModel({
    required this.model1,
    required this.model2,
    required this. length_of_model1,
    required this. length_of_model2,

  });

  factory CombineModel.fromJson(Map<String, dynamic> json) => CombineModel(
    model1: json["Model1"],
    model2: json["Model2"],
    length_of_model1: json["lenp"],
    length_of_model2: json["leng"],

  );

  Map<dynamic, dynamic> toJson() => {
    "Model1": model1,
    "Model1": model2,
    "lenp": length_of_model1,
    "leng": length_of_model2,

  };
}