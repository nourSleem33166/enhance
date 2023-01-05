import 'package:enhance/app/modules/register/register_repository.dart';
import 'package:enhance/app/modules/user_communities/user_communities_repository.dart';
import 'package:enhance/app/shared/models/user_model.dart';
import 'package:enhance/app/shared/services/storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'splash_controller.g.dart';

class SplashController = _SplashControllerBase with _$SplashController;

abstract class _SplashControllerBase with Store {
  @action
  Future navigateHomeOrLogin() async {
    RegisterRepository.user = await SharedPreferencesHelper.getUser();
    UserCommunitiesRepository.selectedCommunity =
        await SharedPreferencesHelper.getSelectedCommunity();
    if (RegisterRepository.user == null)
      Future.delayed(Duration(seconds: 5),
          () => Modular.to.pushReplacementNamed("/login"));
    else if (UserCommunitiesRepository.selectedCommunity == null)
      Future.delayed(Duration(seconds: 5),
          () => Modular.to.pushReplacementNamed("/userCommunities"));
    else
      Future.delayed(
          Duration(seconds: 5), () => Modular.to.pushReplacementNamed("/home"));
  }
}
