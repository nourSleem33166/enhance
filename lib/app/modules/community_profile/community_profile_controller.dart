import 'package:bot_toast/bot_toast.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:enhance/app/modules/community_profile/community_profile_repository.dart';
import 'package:enhance/app/modules/profile/profile_repository.dart';
import 'package:enhance/app/modules/register/register_repository.dart';
import 'package:enhance/app/shared/exceptions/enhance_exception.dart';
import 'package:enhance/app/shared/models/community_model.dart';
import 'package:enhance/app/shared/models/community_profile_model.dart';
import 'package:enhance/app/shared/models/countries_model.dart';
import 'package:enhance/app/shared/models/page_state.dart';
import 'package:enhance/app/shared/models/sub_category_model.dart';
import 'package:enhance/app/shared/regx/enhance_regx.dart';
import 'package:enhance/app/shared/widgets/enhance_toast.dart';
import 'package:enhance/app/shared/widgets/textFieldEmptyChecker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:enhance/generated/locale_keys.g.dart';

part 'community_profile_controller.g.dart';

class CommunityProfileController = _CommunityProfileControllerBase
    with _$CommunityProfileController;

abstract class _CommunityProfileControllerBase with Store {
  CommunityProfileRepository _communityProfileRepository;

  _CommunityProfileControllerBase(this._communityProfileRepository);

  CommunityProfileModel communityData;
  List<CommunityModel> userCommunities;

  bool joined;
  bool calledFromVisitor = false;
  @observable
  PageState pageState;

  Future joinCommunity(int id) async {
    BotToast.showLoading();
    bool res = await _communityProfileRepository.joinCommunity(id);
    BotToast.closeAllLoading();
    if (res) {
      Modular.to.pop();
      Modular.to.pop();
      showToast(
          "Join request sent!,please check again later to see if you're joined");
    }
  }

  Future leaveCommunity(int id) async {
    BotToast.showLoading();
    bool res = await _communityProfileRepository.leaveCommunity(id);
    BotToast.closeAllLoading();
    if (res) {
      showToast("Leave Community Done");
    }
  }

  Future<void> initValues(int id) async {
    try {
      this.calledFromVisitor = calledFromVisitor;
      pageState = PageState.loading;
      userCommunities = await _communityProfileRepository.getAdminCommunities();
      userCommunities
          .addAll(await _communityProfileRepository.getJoinedCommunities());
      communityData = await _communityProfileRepository.getCommunityProfile(id);
      joined = isJoined();
      pageState = PageState.fetchDone;
    } on EnhanceException catch (e) {
      showToast(e.key);
      pageState = PageState.fetchFailed;
    }
  }

  bool isJoined() {
    for (int i = 0; i < userCommunities.length; i++) {
      if (userCommunities[i].id == communityData.id) return true;
    }
    return false;
  }
}
