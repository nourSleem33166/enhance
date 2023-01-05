import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:enhance/app/modules/register/register_repository.dart';
import 'package:enhance/app/modules/user_communities/user_communities_repository.dart';
import 'package:enhance/app/shared/exceptions/enhance_exception.dart';
import 'package:enhance/app/shared/models/community_model.dart';
import 'package:enhance/app/shared/models/page_state.dart';
import 'package:enhance/app/shared/widgets/enhance_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:enhance/generated/locale_keys.g.dart';
import 'dart:async';

part 'search_communities_controller.g.dart';

class SearchCommunitiesController = _SearchCommunitiesControllerBase
    with _$SearchCommunitiesController;

abstract class _SearchCommunitiesControllerBase with Store {
  UserCommunitiesRepository _repository;

  _SearchCommunitiesControllerBase(this._repository);


@observable
bool isSearching=false;

  ObservableList<CommunityModel> searchedCommunities =
      ObservableList<CommunityModel>();
  TextEditingController searchController=TextEditingController();

  @action
  Future searchForCommunity(String query) async {
    isSearching=true;
    searchedCommunities.clear();
    searchedCommunities.addAll(await _repository.searchCommunity(query));
    isSearching=false;
  }

  Future onCommunitySelected(int id) async {
    Modular.to.pushNamed("/community_profile",arguments:[id] );
  }
}
