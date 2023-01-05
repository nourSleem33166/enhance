import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:enhance/app/modules/register/register_repository.dart';
import 'package:enhance/app/modules/user_communities/user_communities_repository.dart';
import 'package:enhance/app/shared/exceptions/enhance_exception.dart';
import 'package:enhance/app/shared/models/community_model.dart';
import 'package:enhance/app/shared/models/page_state.dart';
import 'package:enhance/app/shared/services/storage_service.dart';
import 'package:enhance/app/shared/widgets/enhance_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:enhance/generated/locale_keys.g.dart';

part 'user_communities_controller.g.dart';

class UserCommunitiesController = _UserCommunitiesControllerBase with _$UserCommunitiesController;

abstract class _UserCommunitiesControllerBase with Store {
  UserCommunitiesRepository _repository;

  _UserCommunitiesControllerBase(this._repository);

  List<CommunityModel> joinedCommunities=[];
  List<CommunityModel> adminCommunities=[];



  @observable
  PageState pageState=PageState.loading;

  Future<void> initValues () async {
    try{
      pageState=PageState.loading;
      joinedCommunities=await _repository.getJoinedCommunities();
      adminCommunities=await _repository.getAdminCommunities();
      pageState=PageState.fetchDone;
    }on EnhanceException catch(e){
      pageState=PageState.fetchFailed;
      showToast(e.key);
    }
  }


  Future navigateToHome(CommunityModel communityModel) async {
    UserCommunitiesRepository.selectedCommunity=communityModel;
    await SharedPreferencesHelper.setSelectedCommunity(communityModel);
    Modular.to.pushReplacementNamed("/home",arguments: communityModel.id);
  }

}
