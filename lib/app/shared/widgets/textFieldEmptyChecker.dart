import 'package:enhance/app/shared/widgets/enhance_toast.dart';
import 'package:flutter/material.dart';
import 'package:enhance/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
bool notEmptyTextField (List<TextEditingController> controllers){
  for (int i=0;i<controllers.length;i++){
    if (controllers[i].text.trim().isEmpty){
      showToast(LocaleKeys.pleaseFillAllRequiredData.tr());
      return false;

    }
  }
  return true;
}