import 'package:dio/dio.dart';
import 'package:enhance/app/modules/register/login/login_page.dart';
import 'package:enhance/app/modules/register/register_repository.dart';
import 'package:enhance/app/modules/register/sign_up/sign_up_controller.dart';
import 'package:enhance/app/modules/register/sign_up/sign_up_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'login/login_controller.dart';

class LoginModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => LoginController(RegisterRepository(i.get<Dio>()))),
        Bind((i) => SignUpController(RegisterRepository(i.get<Dio>()))),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => LoginPage()),
        ModularRouter('/signUp', child: (_, args) => SignUpPage()),
      ];
}
