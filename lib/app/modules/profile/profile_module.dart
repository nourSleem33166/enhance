import 'package:dio/dio.dart';
import 'package:enhance/app/modules/profile/profile_page.dart';
import 'package:enhance/app/modules/profile/profile_repository.dart';
import 'package:enhance/app/modules/register/login/login_page.dart';
import 'package:enhance/app/modules/register/register_repository.dart';
import 'package:enhance/app/modules/register/sign_up/sign_up_controller.dart';
import 'package:enhance/app/modules/register/sign_up/sign_up_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'profile_controller.dart';

class ProfileModule extends ChildModule {
  @override
  List<Bind> get binds => [
    Bind((i) => ProfileController(ProfileRepository(i.get<Dio>()))),
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter(Modular.initialRoute, child: (_, args) => ProfilePage()),
  ];
}
