import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:enhance/app/modules/profile/profile_controller.dart';
import 'package:enhance/app/modules/register/register_repository.dart';
import 'package:enhance/app/modules/register/sign_up/sign_up_controller.dart';
import 'package:enhance/app/shared/exceptions/exceptions_handler.dart';
import 'package:enhance/app/shared/models/community_profile_model.dart';
import 'package:enhance/app/shared/models/countries_model.dart';
import 'package:enhance/app/shared/models/user_model.dart';
import 'package:enhance/app/shared/services/storage_service.dart';
import 'package:enhance/app/shared/widgets/enhance_toast.dart';

class ProfileRepository {
  final Dio _dio;

  ProfileRepository(Dio dio) : _dio = dio;


  Future<List<CountryModel>> getCountries() async {
    try {
      final response = await _dio.get('/constants/countries');
      if (response?.data != null)
        return countryModelFromJson(json.encode(response?.data));
      else
        return null;
    } on DioError catch (exception, stack) {
      ExceptionsHandler.dioExceptionsHandler(exception, stack);
    }
  }

  Future<List<Category>> getCategories() async {
    try {
      final response = await _dio.get('/constants/categories');
      if (response?.data != null)
        return categoryModelFromJson(json.encode(response?.data));
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

  Future <void> refreshUser()async{
    try {
      String password=await SharedPreferencesHelper.getPassword();
      final response = await _dio.post('/auth', data: {
        "email": RegisterRepository.user.email,
        "password": password,
      });
      if (response?.statusCode == 200) {
        RegisterRepository.user = userModelFromJson(jsonEncode(response.data));
        await SharedPreferencesHelper.setUser(RegisterRepository.user);
      } else {
        showToast("Credintials Error");
      }
    } on DioError catch (exception, stack) {
      ExceptionsHandler.dioExceptionsHandler(exception, stack);
      return null;
    }
  }
  Future<bool> updateUser(UpdateUserParams updateUserParams) async {
    try {
      final response = await _dio.put('/user', data: {
        "firstName": updateUserParams.firstName,
        "lastName": updateUserParams.lastName,
        "phone": updateUserParams.phone,
        "profession": updateUserParams.profession,
        "bio": updateUserParams.bio,
        "cityId": updateUserParams.cityId,
        "profileImage": updateUserParams.profileImage,
        "invitationOption": false,
        "addedCategories": updateUserParams.addedCategories == null
            ? []
            : List<dynamic>.from(
            updateUserParams.addedCategories.map((x) => x)),
        "deletedCategories": updateUserParams.deletedCategories == null
            ? []
            : List<dynamic>.from(
            updateUserParams.deletedCategories.map((x) => x)),
      });
      if (response?.statusCode == 200)
        {
          await refreshUser();
          return true;
        }

      else
        return false;
    } on DioError catch (exception, stack) {
      ExceptionsHandler.dioExceptionsHandler(exception, stack);
      return null;
    }
  }
}
