import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:enhance/app/modules/register/sign_up/sign_up_controller.dart';
import 'package:enhance/app/shared/exceptions/exceptions_handler.dart';
import 'package:enhance/app/shared/models/community_profile_model.dart';
import 'package:enhance/app/shared/models/countries_model.dart';
import 'package:enhance/app/shared/models/sub_category_model.dart';
import 'package:enhance/app/shared/models/user_model.dart';
import 'package:enhance/app/shared/services/storage_service.dart';
import 'package:enhance/app/shared/widgets/enhance_toast.dart';

class RegisterRepository {
  final Dio _register;
  static UserModel user;

  RegisterRepository(Dio register) : _register = register;

  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _register.post('/auth', data: {
        "email": email,
        "password": password,
      });
      if (response?.statusCode == 200) {
        user = userModelFromJson(jsonEncode(response.data));
        await SharedPreferencesHelper.setUser(user);
        await SharedPreferencesHelper.setPassword(password);
        return user;
      } else {
        showToast("Credintials Error");
        return null;
      }
    } on DioError catch (exception, stack) {
      if (exception.type == DioErrorType.RESPONSE)
        showToast("Credintials Error");
      else
        ExceptionsHandler.dioExceptionsHandler(exception, stack);
      return null;
    }
  }

  Future<List<CountryModel>> getCountries() async {
    try {
      final response = await _register.get('/constants/countries');
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
      final response = await _register.get('/constants/categories');
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
    final Response response = await _register.post("/uploadImage", data: data);
    if (response != null && response.statusCode == 200) {
      print(response.data["imageUrl"]);
      return response.data["imageUrl"];
    }
    return null;
  }

  Future<UserModel> signUp(SignUpParams signUpParams) async {
    try {
      final response = await _register.post('/auth/signUp', data: {
        "firstName": signUpParams.firstName,
        "lastName": signUpParams.lastName,
        "email": signUpParams.email,
        "age": signUpParams.age,
        "phone": signUpParams.phone,
        "profileImage": signUpParams.profileImage,
        "profession": signUpParams.profession,
        "address": signUpParams.address,
        "username": signUpParams.userName,
        "bio": signUpParams.bio,
        "cityId": signUpParams.cityId,
        "password": signUpParams.password,
        "invitationOption": signUpParams.invitationOption,
        "categories": signUpParams.categories == null
            ? null
            : List<dynamic>.from(signUpParams.categories.map((x) => x)),
      });
      if (response?.statusCode == 200)
        return userModelFromJson(jsonEncode(response.data));
      else
        return null;
    } on DioError catch (exception, stack) {
      ExceptionsHandler.dioExceptionsHandler(exception, stack);
      return null;
    }
  }
}
