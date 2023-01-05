import 'package:enhance/app/shared/colors.dart';
import 'package:enhance/app/shared/font_styles.dart';
import 'package:flutter/material.dart';

AppBar appBar(String title) {
  return AppBar(title: Text(title, style: regularStyle(
      fontSize: 16, color: EnhanceColors.color(ColorType.primary)),),backgroundColor: EnhanceColors.color(ColorType.secondary),);
}