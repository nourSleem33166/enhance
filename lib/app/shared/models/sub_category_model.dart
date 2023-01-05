// To parse this JSON data, do
//
//     final subCategoryModel = subCategoryModelFromJson(jsonString);

import 'dart:convert';

List<SubCategoryModel> subCategoryModelFromJson(String str) => List<SubCategoryModel>.from(json.decode(str).map((x) => SubCategoryModel.fromJson(x)));


class SubCategoryModel {
  SubCategoryModel({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );
}
