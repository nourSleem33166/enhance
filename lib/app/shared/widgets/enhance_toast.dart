import 'package:bot_toast/bot_toast.dart';
import 'package:enhance/app/shared/colors.dart';
import 'package:enhance/app/shared/font_styles.dart';
import 'package:flutter/material.dart';

void showToast(String text) => BotToast.showText(duration: Duration(milliseconds: 1500),
    text: text,
    contentColor: EnhanceColors.color(ColorType.secondary13),
    textStyle:
    regularStyle(color: EnhanceColors.color(ColorType.primary), fontSize: 16),
    borderRadius: BorderRadius.all(Radius.circular(15)));