import 'dart:convert';

List<Category> categoryModelFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

CommunityProfileModel communityProfileModelFromJson(String str) =>
    CommunityProfileModel.fromJson(json.decode(str));

String communityProfileModelToJson(CommunityProfileModel data) =>
    json.encode(data.toJson());

class CommunityProfileModel {
  CommunityProfileModel({
    this.id,
    this.label,
    this.description,
    this.primaryColor,
    this.accentColor,
    this.warnColor,
    this.verified,
    this.deletedAt,
    this.coverImage,
    this.category,
    this.subcategories,
    this.userSettings,
    this.users,
  });

  int id;
  String label;
  String description;
  dynamic primaryColor;
  dynamic accentColor;
  dynamic warnColor;
  bool verified;
  dynamic deletedAt;
  String coverImage;
  Category category;
  List<Subcategory> subcategories;
  UserSettings userSettings;
  List<User> users;

  factory CommunityProfileModel.fromJson(Map<String, dynamic> json) =>
      CommunityProfileModel(
        id: json["id"] == null ? null : json["id"],
        label: json["label"] == null ? null : json["label"],
        description: json["description"] == null ? null : json["description"],
        primaryColor: json["primaryColor"],
        accentColor: json["accentColor"],
        warnColor: json["warnColor"],
        verified: json["verified"] == null ? null : json["verified"],
        deletedAt: json["deletedAt"],
        coverImage: json["coverImage"] == null ? null : json["coverImage"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        subcategories: json["subcategories"] == null
            ? null
            : List<Subcategory>.from(
                json["subcategories"].map((x) => Subcategory.fromJson(x))),
        userSettings: json["userSettings"] == null
            ? null
            : UserSettings.fromJson(json["userSettings"]),
        users: json["users"] == null
            ? null
            : List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "label": label == null ? null : label,
        "description": description == null ? null : description,
        "primaryColor": primaryColor,
        "accentColor": accentColor,
        "warnColor": warnColor,
        "verified": verified == null ? null : verified,
        "deletedAt": deletedAt,
        "coverImage": coverImage == null ? null : coverImage,
        "category": category == null ? null : category.toJson(),
        "subcategories": subcategories == null
            ? null
            : List<dynamic>.from(subcategories.map((x) => x.toJson())),
        "userSettings": userSettings == null ? null : userSettings.toJson(),
        "users": users == null
            ? null
            : List<dynamic>.from(users.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}

class Subcategory {
  Subcategory({
    this.id,
    this.name,
    this.deletedAt,
  });

  int id;
  String name;
  dynamic deletedAt;

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "deletedAt": deletedAt,
      };
}

class UserSettings {
  UserSettings({
    this.id,
    this.communityName,
    this.primaryColor,
    this.accentColor,
    this.warnColor,
    this.communityRating,
    this.userRating,
    this.priority,
    this.isJoined,
    this.restrictions,
  });

  int id;
  String communityName;
  dynamic primaryColor;
  dynamic accentColor;
  dynamic warnColor;
  dynamic communityRating;
  dynamic userRating;
  int priority;
  dynamic isJoined;
  dynamic restrictions;

  factory UserSettings.fromJson(Map<String, dynamic> json) => UserSettings(
        id: json["id"] == null ? null : json["id"],
        communityName:
            json["communityName"] == null ? null : json["communityName"],
        primaryColor: json["primaryColor"],
        accentColor: json["accentColor"],
        warnColor: json["warnColor"],
        communityRating: json["communityRating"],
        userRating: json["userRating"],
        priority: json["priority"] == null ? null : json["priority"],
        isJoined: json["isJoined"],
        restrictions: json["restrictions"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "communityName": communityName == null ? null : communityName,
        "primaryColor": primaryColor,
        "accentColor": accentColor,
        "warnColor": warnColor,
        "communityRating": communityRating,
        "userRating": userRating,
        "priority": priority == null ? null : priority,
        "isJoined": isJoined,
        "restrictions": restrictions,
      };
}

class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.profileImage,
    this.bio,
    this.profession,
    this.settings,
  });

  int id;
  String firstName;
  String lastName;
  String profileImage;
  String bio;
  String profession;
  Settings settings;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        profileImage:
            json["profile_image"] == null ? null : json["profile_image"],
        bio: json["bio"] == null ? null : json["bio"],
        profession: json["profession"] == null ? null : json["profession"],
        settings: json["settings"] == null
            ? null
            : Settings.fromJson(json["settings"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "profile_image": profileImage == null ? null : profileImage,
        "bio": bio == null ? null : bio,
        "profession": profession == null ? null : profession,
        "settings": settings == null ? null : settings.toJson(),
      };
}

class Settings {
  Settings({
    this.id,
    this.communityName,
    this.communityRating,
    this.userRating,
    this.priority,
    this.userId,
  });

  int id;
  String communityName;
  dynamic communityRating;
  dynamic userRating;
  int priority;
  int userId;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        id: json["id"] == null ? null : json["id"],
        communityName:
            json["communityName"] == null ? null : json["communityName"],
        communityRating: json["communityRating"],
        userRating: json["userRating"],
        priority: json["priority"] == null ? null : json["priority"],
        userId: json["userId"] == null ? null : json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "communityName": communityName == null ? null : communityName,
        "communityRating": communityRating,
        "userRating": userRating,
        "priority": priority == null ? null : priority,
        "userId": userId == null ? null : userId,
      };
}
