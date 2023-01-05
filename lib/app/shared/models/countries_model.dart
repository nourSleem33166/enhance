// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

List<CountryModel> countryModelFromJson(String str) => List<CountryModel>.from(
    json.decode(str).map((x) => CountryModel.fromJson(x)));

class CountryModel {
  CountryModel({
    this.id,
    this.name,
    this.cities,
  });

  int id;
  String name;
  List<City> cities;

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        cities: json["cities"] == null
            ? null
            : List<City>.from(json["cities"].map((x) => City.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "cities": cities == null
            ? null
            : List<dynamic>.from(cities.map((x) => x.toJson())),
      };
}

class City {
  City({
    this.id,
    this.name,
  });

  int id;
  String name;
  CountryModel country;

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "country": country == null ? null : country.toJson(),
      };
}
