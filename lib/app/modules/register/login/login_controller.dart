import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:enhance/app/modules/register/register_repository.dart';
import 'package:enhance/app/shared/exceptions/enhance_exception.dart';
import 'package:enhance/app/shared/regx/enhance_regx.dart';
import 'package:enhance/app/shared/widgets/enhance_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:enhance/generated/locale_keys.g.dart';

part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  RegisterRepository _registerRepository;

  _LoginControllerBase(this._registerRepository);

  @observable
  bool validEmail = false;

  @observable
  bool validPassword = false;

  @computed
  bool get loginButtonEnabled => validEmail && validPassword;

  @action
  Future login(String email, String password) async {
    try {
      if (email == "" || password == "")
        showToast("please fill credentials");
      else {
        BotToast.showLoading();
        final result = await _registerRepository.login(email, password);
        BotToast.closeAllLoading();
        if (result == null)
          showToast("Credential Error");
        else
          Modular.to.pushReplacementNamed("/userCommunities");
      }
    } on EnhanceException catch (e) {
      BotToast.closeAllLoading();
      showToast(e.key);
    }
  }

  @action
  Future resetPassword() async {
    Modular.to.pushNamed("/login/resetPassword");
  }

  Future navigateToUserCommunities() async {
    Modular.to.pushNamed("/userCommunities");
  }

  Future signUp() async {
    Modular.to.pushNamed("/login/signUp");
  }

  String emailValidator(String value) {
    if (value.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        validEmail = false;
      });
      return LocaleKeys.mustFillEmail.tr();
    }
    if (EnhanceRegExp.email.hasMatch(value)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        validEmail = true;
      });
      return null;
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        validEmail = false;
      });
      return LocaleKeys.invalidEmail.tr();
    }
  }

  String passwordValidator(String value) {
    return null;
    // if (value.isEmpty) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     validPassword = false;
    //   });
    //   return LocaleKeys.mustFillPassword.tr();
    // } else {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     validPassword = true;
    //   });
    //   return null;
    // }
  }
}
