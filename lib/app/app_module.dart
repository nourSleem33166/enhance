import 'package:enhance/app/app_controller.dart';
import 'package:enhance/app/app_widget.dart';
import 'package:enhance/app/modules/community_profile/community_profile_module.dart';
import 'package:enhance/app/modules/home/home_module.dart';
import 'package:enhance/app/modules/splash/splash_controller.dart';
import 'package:enhance/app/shared/dio/dio_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/profile/profile_module.dart';
import 'modules/register/register_module.dart';
import 'modules/splash/splash_page.dart';
import 'modules/user_communities/user_communities_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController(), singleton: true),
        Bind((i) => DioFactory.create(), singleton: false),
        Bind((i) => SplashController()),
      ];

  @override
  List<ModularRouter> get routers => [
        // ModularRouter("/splash", child: (_, args) => SplashPage()),
        ModularRouter("/splash", child: (_, args) => SplashPage()),
        ModularRouter("/login", module: LoginModule()),
        ModularRouter("/userCommunities", module: UserCommunitiesModule()),
        ModularRouter("/home", module: HomeModule()),
        ModularRouter("/profile", module: ProfileModule()),
        ModularRouter("/community_profile", module: CommunityProfileModule()),

        // ModularRouter(HomeModule.initialRoute, module: HomeModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();
}
