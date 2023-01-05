import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:enhance/app/modules/register/sign_up/sign_up_controller.dart';
import 'package:enhance/app/shared/exceptions/exceptions_handler.dart';
import 'package:enhance/app/shared/models/community_model.dart';
import 'package:enhance/app/shared/models/community_profile_model.dart';
import 'package:enhance/app/shared/models/countries_model.dart';
import 'package:enhance/app/shared/widgets/enhance_toast.dart';

class CommunityProfileRepository {
  final Dio _dio;

  CommunityProfileRepository(Dio dio) : _dio = dio;

  Future<List<CommunityModel>> getJoinedCommunities() async {
    try {
      final response = await _dio.get('/user/joinedCommunities');
      if (response?.data != null)
        return communityModelFromJson(json.encode(response?.data));
      else
        return null;
    } on DioError catch (exception, stack) {
      ExceptionsHandler.dioExceptionsHandler(exception, stack);
    }
  }

  Future<List<CommunityModel>> getAdminCommunities() async {
    try {
      final response = await _dio.get('/user/ownedCommunities');
      if (response?.data != null)
        return communityModelFromJson(json.encode(response?.data));
      else
        return null;
    } on DioError catch (exception, stack) {
      ExceptionsHandler.dioExceptionsHandler(exception, stack);
    }
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

  Future<bool> joinCommunity(int id) async {
    try {
      final response = await _dio.post('/user/joinCommunity', queryParameters: {
        "communityId": id,
      });
      if (response?.statusCode == 200) {
        return true;
      } else {
        showToast("Error happened sending join request");
        return null;
      }
    } on DioError catch (exception, stack) {
      ExceptionsHandler.dioExceptionsHandler(exception, stack);
      return null;
    }
  }


  Future<bool> leaveCommunity(int id) async {
    try {
      final response = await _dio.delete('/user/leaveCommunity', queryParameters: {
        "communityId": id,
      });
      if (response?.statusCode == 200) {
        return true;
      } else {
        showToast("Error happened Leaving Community");
        return null;
      }
    } on DioError catch (exception, stack) {
      ExceptionsHandler.dioExceptionsHandler(exception, stack);
      return null;
    }
  }
}
