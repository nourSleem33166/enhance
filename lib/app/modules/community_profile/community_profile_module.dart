import 'package:dio/dio.dart';
import 'package:enhance/app/modules/community_profile/community_profile_controller.dart';
import 'package:enhance/app/modules/community_profile/community_profile_page.dart';
import 'package:enhance/app/modules/community_profile/community_profile_repository.dart';
import 'package:enhance/app/modules/profile/profile_page.dart';
import 'package:enhance/app/modules/profile/profile_repository.dart';
import 'package:enhance/app/modules/register/login/login_page.dart';
import 'package:enhance/app/modules/register/register_repository.dart';
import 'package:enhance/app/modules/register/sign_up/sign_up_controller.dart';
import 'package:enhance/app/modules/register/sign_up/sign_up_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CommunityProfileModule extends ChildModule {
  @override
  List<Bind> get binds => [
    Bind((i) => CommunityProfileController(CommunityProfileRepository(i.get<Dio>()))),
  ];

  @override
  List<ModularRouter> get routers => [
    ModularRouter(Modular.initialRoute, child: (_, args) => CommunityProfilePage(args.data[0])),
  ];
}
