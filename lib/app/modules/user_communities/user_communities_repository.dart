import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:enhance/app/modules/register/sign_up/sign_up_controller.dart';
import 'package:enhance/app/shared/exceptions/exceptions_handler.dart';
import 'package:enhance/app/shared/models/community_model.dart';
import 'package:enhance/app/shared/models/countries_model.dart';

class UserCommunitiesRepository {
  final Dio _dio;

  UserCommunitiesRepository(Dio dio) : _dio = dio;

  static CommunityModel selectedCommunity;

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

  Future<List<CommunityModel>> searchCommunity(String pattern) async {
    try {
      final response = await _dio.get('/community/search',queryParameters: {
        "label":pattern
      });
      if (response?.data != null)
        return communityModelFromJson(json.encode(response?.data));
      else
        return null;
    } on DioError catch (exception, stack) {
      ExceptionsHandler.dioExceptionsHandler(exception, stack);
    }
  }

}