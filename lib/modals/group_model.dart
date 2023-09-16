// To parse this JSON data, do
//
//     final groupModel = groupModelFromJson(jsonString);

import 'dart:convert';

GroupModel groupModelFromJson(String str) => GroupModel.fromJson(json.decode(str));

String groupModelToJson(GroupModel data) => json.encode(data.toJson());

class GroupModel {
  int groupId;
  String groupName;
  int isDeletable;

  GroupModel({
    required this.groupId,
    required this.groupName,
    required this.isDeletable
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) => GroupModel(
    groupId: json["groupId"],
    groupName: json["groupName"],
    isDeletable: json["isDeletable"]
  );

  Map<String, dynamic> toJson() => {
    "groupId": groupId,
    "groupName": groupName,
    "isDeletable": isDeletable,
  };
}
