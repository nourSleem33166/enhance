import 'package:flutter/material.dart';

enum ColorType {
  primary,
  secondary,
  accent,
  primaryTextColor,
  secondaryTextColor,
  labelColor,
  secondary13,
  secondary12,
  secondary11
}

  class EnhanceColors {
  static Brightness theme = Brightness.light;
  static Map<Brightness, Map<ColorType, Color>> colorsScheme = {
    Brightness.light: {
      ColorType.primary: Color(0xffECECEE),
      ColorType.secondary: Color(0xfff96332),
      ColorType.accent: Color(0xff2196f3),
      ColorType.primaryTextColor: Color(0xff2E323E),
      ColorType.secondaryTextColor: Color(0xff9EA1A9),
      ColorType.labelColor: Color(0xff7D818C),
      ColorType.secondary13: Color(0xfff96332),
      ColorType.secondary12: Color(0xff1E2129),
      ColorType.secondary11: Color(0xff03A9F4),
    },
    Brightness.dark: {
      ColorType.primary: Color(0xff2E323E),
      ColorType.secondary: Color(0xff672382),
      ColorType.accent: Color(0xffDFBA8D),
      ColorType.primaryTextColor: Color(0xffECECEE),
      ColorType.secondaryTextColor: Color(0xff9EA1A9),
      ColorType.labelColor: Color(0xff7D818C),
      ColorType.secondary13: Color(0xfff96332),
      ColorType.secondary12: Color(0xff1E2129),
      ColorType.secondary11: Color(0xff03A9F4)
    }
  };

  static Color color(ColorType colorType) => colorsScheme[theme][colorType];
}
