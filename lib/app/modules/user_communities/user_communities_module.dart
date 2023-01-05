import 'package:dio/dio.dart';
import 'package:enhance/app/modules/register/login/login_page.dart';
import 'package:enhance/app/modules/register/register_repository.dart';
import 'package:enhance/app/modules/register/sign_up/sign_up_controller.dart';
import 'package:enhance/app/modules/register/sign_up/sign_up_page.dart';
import 'package:enhance/app/modules/user_communities/search_communities/search_communities_controller.dart';
import 'package:enhance/app/modules/user_communities/search_communities/search_communities_page.dart';
import 'package:enhance/app/modules/user_communities/user_communities_controller.dart';
import 'package:enhance/app/modules/user_communities/user_communities_page.dart';
import 'package:enhance/app/modules/user_communities/user_communities_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';


class UserCommunitiesModule extends ChildModule {
  @override
  List<Bind> get binds => [
    Bind((i) => UserCommunitiesController(UserCommunitiesRepository(i.get<Dio>()))),
    Bind((i) => SearchCommunitiesController(UserCommunitiesRepository(i.get<Dio>()))),

  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter(Modular.initialRoute, child: (_, args) => UserCommunitiesPage()),
    ModularRouter("/searchCommunities", child: (_, args) => SearchCommunitiesPage()),

  ];
}
