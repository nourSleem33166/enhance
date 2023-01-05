
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Formatters {
  static String humanDateTime(BuildContext context,DateTime date) =>
      humanDate(context,date) + "   " + humanTime(date);

  static String humanDate(BuildContext context,DateTime date) {
    if(context.locale==Locale("en"))
      return DateFormat.yMMMMEEEEd().format(date);
    else
      return DateFormat.yMMMMEEEEd("tr_TR").format(date);
  }

  static String humanTime(DateTime date) => DateFormat(DateFormat.HOUR24_MINUTE).format(date);

  static String humanDateWithSpaces(DateTime date) =>
      DateFormat("EEE MMM dd yyyy").format(date);
  static String dateOnlyFormat(DateTime date) =>
      DateFormat("dd-MM-yyyy").format(date);
  static String dateOnlyFormatPoints(DateTime date) =>
      DateFormat("dd-MM-yyyy").format(date);

  static String colorToHex(Color color) {
    String hexColor = color.value.toRadixString(16);
    hexColor = hexColor.substring(2);
    return "#$hexColor";
  }

  static Color hexToColor(String hexColor) {
    return Color(int.parse(hexColor.replaceAll("#", "0xff")));
  }

}
