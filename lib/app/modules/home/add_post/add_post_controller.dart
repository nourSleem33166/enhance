import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:enhance/app/modules/home/home_repository.dart';
import 'package:enhance/app/modules/register/register_repository.dart';
import 'package:enhance/app/modules/user_communities/user_communities_repository.dart';
import 'package:enhance/app/shared/exceptions/enhance_exception.dart';
import 'package:enhance/app/shared/models/community_model.dart';
import 'package:enhance/app/shared/models/page_state.dart';
import 'package:enhance/app/shared/models/post_model.dart';
import 'package:enhance/app/shared/models/sub_category_model.dart';
import 'package:enhance/app/shared/widgets/enhance_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:enhance/generated/locale_keys.g.dart';

import '../home_controller.dart';

part 'add_post_controller.g.dart';

class AddPostController = _AddPostControllerBase with _$AddPostController;

abstract class _AddPostControllerBase with Store {
  HomeRepository _repository;

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  String attachmentLink;

  PickedFile pickedImage;

  PostsType selectedPostType;
  @observable
  File imageFile;

  int selectedSubCategoryId;

  @observable
  bool isAnonymous = false;

  _AddPostControllerBase(this._repository);

  @observable
  PageState pageState = PageState.loading;

  Future<void> initValues(int subCategoryId, PostsType selectedPostType) async {
    try {
      selectedSubCategoryId = subCategoryId;
      this.selectedPostType = selectedPostType;
    } on EnhanceException catch (e) {
      pageState = PageState.fetchFailed;
      showToast(e.key);
    }
  }

  @action
  Future deleteImage() async {
    imageFile = null;
    pickedImage = null;
  }

  Future pickImage() async {
    pickedImage = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    print("pickedFile ${pickedImage.path}");
    imageFile = File(pickedImage.path);
  }

  Future createPost() async {
    if (title.text.isEmpty || description.text.isEmpty)
      showToast("Please fill all required data");
    else
      try {
        BotToast.showLoading();
        if (imageFile != null)
          attachmentLink = await _repository.uploadImage(imageFile);
        final communityProfile = await _repository.getCommunityProfile(
            UserCommunitiesRepository.selectedCommunity.id);
        AddPostParams addPostParams = AddPostParams(
            description: description.text,
            title: title.text,
            attachments: attachmentLink == null ? [] : [attachmentLink],
            isAnonymous: isAnonymous,
            subCategoryId: selectedSubCategoryId,
            type: selectedPostType == PostsType.objections ? 2 : 1,
            userCommunityId: communityProfile.userSettings.id);

        final res = await _repository.addPost(addPostParams);
        if (res) {
          final refreshedPosts =
              await _repository.getPosts(selectedSubCategoryId);
          BotToast.closeAllLoading();
          Modular.to.pop(refreshedPosts);
        }
      } on EnhanceException catch (e) {
        showToast(e.key);
        BotToast.closeAllLoading();
      }
  }

  @action
  Future changeAnonyState(bool value) async {
    isAnonymous = value;
  }

  Future communityPressed() async {
    ///needs to implement
  }
}

class AddPostParams {
  int userCommunityId;
  int subCategoryId;
  int type;
  String title;
  String description;
  bool isAnonymous;
  List<String> attachments;

  AddPostParams(
      {this.subCategoryId,
      this.attachments = const [],
      this.description,
      this.type,
      this.isAnonymous,
      this.title,
      this.userCommunityId});
}
