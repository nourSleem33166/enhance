// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:enhance/app/shared/models/community_profile_model.dart';
import 'package:enhance/app/shared/models/countries_model.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.profession,
    this.joinedAt,
    this.bio,
    this.invitationOption,
    this.username,
    this.age,
    this.city,
    this.id,
    this.profileImage,
    this.jwtToken,
    this.categories,
  });

  String firstName;
  String lastName;
  String email;
  String phone;
  String profession;
  DateTime joinedAt;
  String bio;
  bool invitationOption;
  String username;
  int age;
  City city;
  int id;
  String profileImage;
  String jwtToken;
  List<Category> categories;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    email: json["email"] == null ? null : json["email"],
    phone: json["phone"] == null ? null : json["phone"],
    profession: json["profession"] == null ? null : json["profession"],
    joinedAt: json["joinedAt"] == null ? null : DateTime.parse(json["joinedAt"]),
    bio: json["bio"] == null ? null : json["bio"],
    invitationOption: json["invitationOption"] == null ? null : json["invitationOption"],
    username: json["username"] == null ? null : json["username"],
    age: json["age"] == null ? null : json["age"],
    city: json["city"] == null ? null : City.fromJson(json["city"]),
    id: json["id"] == null ? null : json["id"],
    profileImage: json["profileImage"] == null ? null : json["profileImage"],
    jwtToken: json["jwtToken"] == null ? null : json["jwtToken"],
    categories: json["categories"] == null ? null : List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName == null ? null : firstName,
    "lastName": lastName == null ? null : lastName,
    "email": email == null ? null : email,
    "phone": phone == null ? null : phone,
    "profession": profession == null ? null : profession,
    "joinedAt": joinedAt == null ? null : joinedAt.toIso8601String(),
    "bio": bio == null ? null : bio,
    "invitationOption": invitationOption == null ? null : invitationOption,
    "username": username == null ? null : username,
    "age": age == null ? null : age,
    "city": city == null ? null : city.toJson(),
    "id": id == null ? null : id,
    "profileImage": profileImage == null ? null : profileImage,
    "jwtToken": jwtToken == null ? null : jwtToken,
    "categories": categories == null ? null : List<dynamic>.from(categories.map((x) => x.toJson())),
  };



}


