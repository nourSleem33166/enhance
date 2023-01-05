import 'package:dio/dio.dart';
import 'package:enhance/app/modules/home/add_post/add_post_controller.dart';
import 'package:enhance/app/modules/home/add_post/add_post_page.dart';
import 'package:enhance/app/modules/home/home_controller.dart';
import 'package:enhance/app/modules/home/home_page.dart';
import 'package:enhance/app/modules/home/home_repository.dart';
import 'package:enhance/app/modules/home/member_profile/member_profile.dart';
import 'package:enhance/app/modules/home/member_profile/member_profile_controller.dart';

import 'package:enhance/app/modules/user_communities/user_communities_controller.dart';
import 'package:enhance/app/modules/user_communities/user_communities_page.dart';
import 'package:enhance/app/modules/user_communities/user_communities_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';


class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
    Bind((i) => HomeController(HomeRepository(i.get<Dio>()))),
    Bind((i) => AddPostController(HomeRepository(i.get<Dio>()))),
    Bind((i) => MemberProfileController(HomeRepository(i.get<Dio>()))),

  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
    ModularRouter("/addPost",child: (_, args) => AddPostPage(args.data[0],args.data[1])),
    ModularRouter("/memberProfile",child: (_, args) => MemberProfile(args.data[0]))

  ];
}
