// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

List<PostModel> postModelFromJson(String str) => List<PostModel>.from(json.decode(str).map((x) => PostModel.fromJson(x)));

String postModelToJson(List<PostModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostModel {
  PostModel({
    this.id,
    this.type,
    this.title,
    this.description,
    this.isAnonymous,
    this.deletedAt,
    this.createdAt,
    this.votes,
    this.attachments,
    this.userVoteValue,
    this.user,
  });

  int id;
  int type;
  String title;
  String description;
  bool isAnonymous;
  dynamic deletedAt;
  DateTime createdAt;
  int votes;
  List<Attachment> attachments;
  int userVoteValue;
  User user;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    id: json["id"] == null ? null : json["id"],
    type: json["type"] == null ? null : json["type"],
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    isAnonymous: json["isAnonymous"] == null ? null : json["isAnonymous"],
    deletedAt: json["deletedAt"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    votes: json["votes"] == null ? null : json["votes"],
    attachments: json["attachments"] == null ? null : List<Attachment>.from(json["attachments"].map((x) => Attachment.fromJson(x))),
    userVoteValue: json["userVoteValue"] == null ? null : json["userVoteValue"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "type": type == null ? null : type,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "isAnonymous": isAnonymous == null ? null : isAnonymous,
    "deletedAt": deletedAt,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "votes": votes == null ? null : votes,
    "attachments": attachments == null ? null : List<dynamic>.from(attachments.map((x) => x.toJson())),
    "userVoteValue": userVoteValue == null ? null : userVoteValue,
    "user": user == null ? null : user.toJson(),
  };
}

class Attachment {
  Attachment({
    this.id,
    this.url,
  });

  int id;
  String url;

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    id: json["id"] == null ? null : json["id"],
    url: json["url"] == null ? null : json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "url": url == null ? null : url,
  };
}

class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.phone,
    this.email,
    this.profileImage,
    this.bio,
    this.profession,
    this.invitationOption,
    this.age,
    this.deletedAt,
    this.joinedAt,
  });

  int id;
  String firstName;
  String lastName;
  String username;
  String phone;
  String email;
  String profileImage;
  String bio;
  String profession;
  bool invitationOption;
  int age;
  dynamic deletedAt;
  DateTime joinedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    firstName: json["firstName"] == null ? null : json["firstName"],
    lastName: json["lastName"] == null ? null : json["lastName"],
    username: json["username"] == null ? null : json["username"],
    phone: json["phone"] == null ? null : json["phone"],
    email: json["email"] == null ? null : json["email"],
    profileImage: json["profileImage"] == null ? null : json["profileImage"],
    bio: json["bio"] == null ? null : json["bio"],
    profession: json["profession"] == null ? null : json["profession"],
    invitationOption: json["invitationOption"] == null ? null : json["invitationOption"],
    age: json["age"] == null ? null : json["age"],
    deletedAt: json["deletedAt"],
    joinedAt: json["joinedAt"] == null ? null : DateTime.parse(json["joinedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "firstName": firstName == null ? null : firstName,
    "lastName": lastName == null ? null : lastName,
    "username": username == null ? null : username,
    "phone": phone == null ? null : phone,
    "email": email == null ? null : email,
    "profileImage": profileImage == null ? null : profileImage,
    "bio": bio == null ? null : bio,
    "profession": profession == null ? null : profession,
    "invitationOption": invitationOption == null ? null : invitationOption,
    "age": age == null ? null : age,
    "deletedAt": deletedAt,
    "joinedAt": joinedAt == null ? null : joinedAt.toIso8601String(),
  };
}
