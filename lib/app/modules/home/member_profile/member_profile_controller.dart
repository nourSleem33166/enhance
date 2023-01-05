import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:enhance/app/modules/home/home_repository.dart';
import 'package:enhance/app/modules/register/register_repository.dart';
import 'package:enhance/app/modules/user_communities/user_communities_repository.dart';
import 'package:enhance/app/shared/exceptions/enhance_exception.dart';
import 'package:enhance/app/shared/models/community_model.dart';
import 'package:enhance/app/shared/models/community_profile_model.dart';
import 'package:enhance/app/shared/models/page_state.dart';
import 'package:enhance/app/shared/models/post_model.dart';
import 'package:enhance/app/shared/models/sub_category_model.dart';
import 'package:enhance/app/shared/models/user_model.dart';
import 'package:enhance/app/shared/widgets/enhance_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:enhance/generated/locale_keys.g.dart';

part 'member_profile_controller.g.dart';

class MemberProfileController = _MemberProfileControllerBase
    with _$MemberProfileController;

abstract class _MemberProfileControllerBase with Store {
  HomeRepository _repository;

  _MemberProfileControllerBase(this._repository);

  @observable
  PageState pageState = PageState.loading;
  UserModel user;

  Future<void> initValues(int userId) async {
    try {
      pageState = PageState.loading;
      this.user = await _repository.getUserById(userId);
      pageState = PageState.fetchDone;
    } on EnhanceException catch (e) {
      pageState = PageState.fetchFailed;
      showToast(e.key);
    }
  }
}
