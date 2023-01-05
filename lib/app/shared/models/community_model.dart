// To parse this JSON data, do
//
//     final communityModel = communityModelFromJson(jsonString);

import 'dart:convert';

List<CommunityModel> communityModelFromJson(String str) => List<CommunityModel>.from(json.decode(str).map((x) => CommunityModel.fromJson(x)));

String communityModelToJson(List<CommunityModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CommunityModel {
  CommunityModel({
    this.id,
    this.label,
    this.image,
    this.description,
  });

  int id;
  String label;
  String image;
  String description;

  factory CommunityModel.fromJson(Map<String, dynamic> json) => CommunityModel(
    id: json["id"] == null ? null : json["id"],
    label: json["label"] == null ? null : json["label"],
    image: json["image"] == null ? null : json["image"],
    description: json["description"] == null ? null : json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "label": label == null ? null : label,
    "image": image == null ? null : image,
    "description": description == null ? null : description,
  };
}
