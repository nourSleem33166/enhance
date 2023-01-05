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
import 'package:enhance/app/shared/widgets/enhance_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:enhance/generated/locale_keys.g.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  HomeRepository _repository;

  _HomeControllerBase(this._repository);

  ObservableList<PostModel> suggestions = ObservableList<PostModel>();
  ObservableList<PostModel> objections = ObservableList<PostModel>();
  ObservableList<PostModel> posts = ObservableList<PostModel>();

  int selectedSubCategoryId;

  List<Subcategory> subCategories;
  @observable
  PostsType selectedPostsType = PostsType.suggestions;

  @observable
  PageState pageState = PageState.loading;

  @observable
  bool loading = false;

  TabController tabController;

  Future<void> initValues(var thisParam) async {
    try {
      pageState = PageState.loading;

      subCategories = await _repository.getSubCategories();
      posts.addAll(await _repository.getPosts(null));
      tabController=TabController(length: subCategories.length+1,vsync: thisParam,initialIndex: 0);
      objections.addAll(posts.where((element) => element.type == 2));
      suggestions.addAll(posts.where((element) => element.type == 1));
      pageState = PageState.fetchDone;
    } on EnhanceException catch (e) {
      pageState = PageState.fetchFailed;
      showToast(e.key);
    }
  }

  @action
  changePostsType(int type) {
    if (type == 0)
      selectedPostsType = PostsType.suggestions;
    else
      selectedPostsType = PostsType.objections;
  }

  @action
  void navigateToAddPost() {
    Modular.to.pushNamed("/home/addPost",
        arguments: [selectedPostsType, selectedSubCategoryId]).then((value) {
          if(value!=null){
            posts.clear();
            objections.clear();
            suggestions.clear();
            posts.addAll(value);
            objections.addAll(posts.where((element) => element.type == 2));
            suggestions.addAll(posts.where((element) => element.type == 1));
          }

    });
  }

  initPosts(int subCategoryId) async {
    loading = true;
    selectedSubCategoryId = subCategoryId;
    posts.clear();
    objections.clear();
    suggestions.clear();
    posts.addAll(await _repository.getPosts(subCategoryId));
    objections.addAll(posts.where((element) => element.type == 2));
    suggestions.addAll(posts.where((element) => element.type == 1));
    loading = false;
  }

  Future sendVote(int postId, int voteValue) async {
    try {
      final communityProfile = await _repository
          .getCommunityProfile(UserCommunitiesRepository.selectedCommunity.id);
      final voteRes = await _repository.sendVote(
          communityProfile.userSettings.id, postId, voteValue);
      return voteRes;
    } on EnhanceException catch (e) {
      showToast(e.key);
    }
  }

  @action
  Future deletePost(int postId) async {
    try {
      BotToast.showLoading();
      final deleteRes = await _repository.deletePost(postId);
      if(deleteRes){
        final tempPosts=await _repository.getPosts(selectedSubCategoryId);
        posts.clear();
        posts.addAll(tempPosts);
        objections.clear();
        suggestions.clear();
        objections.addAll(posts.where((element) => element.type == 2));
        suggestions.addAll(posts.where((element) => element.type == 1));
      }
      BotToast.closeAllLoading();

    } on EnhanceException catch (e) {
      showToast(e.key);
    }
  }

  @action
  Future communityPressed() async {
    ///needs to implement
  }
}

enum PostsType { suggestions, objections }
