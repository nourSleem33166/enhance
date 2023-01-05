import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:enhance/app/modules/community_profile/community_profile_repository.dart';
import 'package:enhance/app/modules/home/add_post/add_post_controller.dart';
import 'package:enhance/app/modules/register/sign_up/sign_up_controller.dart';
import 'package:enhance/app/modules/user_communities/user_communities_repository.dart';
import 'package:enhance/app/shared/exceptions/exceptions_handler.dart';
import 'package:enhance/app/shared/models/community_model.dart';
import 'package:enhance/app/shared/models/community_profile_model.dart';
import 'package:enhance/app/shared/models/countries_model.dart';
import 'package:enhance/app/shared/models/post_model.dart';
import 'package:enhance/app/shared/models/sub_category_model.dart';
import 'package:enhance/app/shared/models/user_model.dart';

class HomeRepository {
  final Dio _dio;

  HomeRepository(Dio dio) : _dio = dio;

  Future<List<PostModel>> getPosts(int subCategoryId) async {
    try {
      final communityProfile = await getCommunityProfile(
          UserCommunitiesRepository.selectedCommunity.id);
      final response = await _dio.get('/posts',
          queryParameters: subCategoryId != -1
              ? {
                  "subCategoryId": subCategoryId,
                  "communityId": UserCommunitiesRepository.selectedCommunity.id,
                  "userCommunityId": communityProfile.userSettings.id
                }
              : {
                  "communityId": UserCommunitiesRepository.selectedCommunity.id,
                  "userCommunityId": communityProfile.userSettings.id
                });

      if (response?.data != null){
        final posts =postModelFromJson(json.encode(response?.data));
        return posts;
      }

      else
        return null;
    } on DioError catch (exception, stack) {
      ExceptionsHandler.dioExceptionsHandler(exception, stack);
    }
  }

  Future<String> uploadImage(File file) async {
    FormData data = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path),
    });
    final Response response = await _dio.post("/uploadImage", data: data);
    if (response != null && response.statusCode == 200) {
      print(response.data["imageUrl"]);
      return response.data["imageUrl"];
    }
    return null;
  }

  Future<CommunityProfileModel> getCommunityProfile(int communityId) async {
    try {
      final response = await _dio
          .get('/community', queryParameters: {"communityId": communityId});
      if (response?.data != null)
        return communityProfileModelFromJson(json.encode(response?.data));
      else
        return null;
    } on DioError catch (exception, stack) {
      ExceptionsHandler.dioExceptionsHandler(exception, stack);
    }
  }

  Future<UserModel> getUserById(int userId) async {
    try {
      final response = await _dio
          .get('/user', queryParameters: {"id": userId});
      if (response?.data != null)
        return userModelFromJson(json.encode(response?.data));
      else
        return null;
    } on DioError catch (exception, stack) {
      ExceptionsHandler.dioExceptionsHandler(exception, stack);
    }
  }

  Future<List<Subcategory>> getSubCategories() async {
    try {
      final communityProfile = await getCommunityProfile(
          UserCommunitiesRepository.selectedCommunity.id);
      final subCategories = communityProfile.subcategories;
      return subCategories;
    } on DioError catch (exception, stack) {
      ExceptionsHandler.dioExceptionsHandler(exception, stack);
    }
  }

  Future<bool> addPost(AddPostParams postParams) async {
    try {
      final response = await _dio.post('/posts', data: {
        "userCommunityId": postParams.userCommunityId,
        "subCategoryId": postParams.subCategoryId,
        "type": postParams.type,
        "title": postParams.title,
        "description": postParams.description,
        "isAnonymous": postParams.isAnonymous,
        "attachments": postParams.attachments == []
            ? []
            : List<dynamic>.from(postParams.attachments.map((x) => x)),
      });
      if (response?.statusCode == 200)
        return true;
      else
        return null;
    } on DioError catch (exception, stack) {
      ExceptionsHandler.dioExceptionsHandler(exception, stack);
      return null;
    }
  }

  ///posts?postId=1&communityId=6
  Future<bool> sendVote(int userCommunityId, int postId, int voteValue) async {
    try {
      final response = await _dio.post('/posts/vote', data: {
        "userCommunityId": userCommunityId,
        "postId": postId,
        "voteValue": voteValue
      });
      if (response?.statusCode == 200)
        return true;
      else
        return false;
    } on DioError catch (exception, stack) {
      ExceptionsHandler.dioExceptionsHandler(exception, stack);
      return false;
    }
  }

  Future<bool> deletePost(int postId) async {
    try {
      final communityProfile = await getCommunityProfile(
          UserCommunitiesRepository.selectedCommunity.id);
      final response = await _dio.delete('/posts', queryParameters: {
        "communityId": UserCommunitiesRepository.selectedCommunity.id,
        "postId": postId,
        "userCommunityId":communityProfile.userSettings.id
      });
      if (response?.statusCode == 200)
        return true;
      else
        return false;
    } on DioError catch (exception, stack) {
      ExceptionsHandler.dioExceptionsHandler(exception, stack);
      return false;
    }
  }
}
