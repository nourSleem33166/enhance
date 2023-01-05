import 'package:enhance/app/shared/colors.dart';
import 'package:enhance/app/shared/font_styles.dart';
import 'package:flutter/material.dart';

class DateTimeTextField extends StatelessWidget {
  TextEditingController controller;
  String labelText;
  String hintText;
  bool underLineTextField;
  Function selectDateFunction;
  Function selectTimeFunction;
  bool dateOnly;
  bool calledInNavigationBottomSheet;
  Color textColor;
  Color fullBorderColor;

  DateTimeTextField(
      {@required this.controller,
      this.labelText,
      this.selectDateFunction,
      this.selectTimeFunction,
      this.calledInNavigationBottomSheet=false,
      this.hintText,
      this.dateOnly = false,
      this.textColor,
      this.fullBorderColor,
      this.underLineTextField = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      cursorColor: EnhanceColors.color(ColorType.accent),
      enabled: true,
      readOnly: true,
      style: regularStyle(
          color: textColor ?? EnhanceColors.color(ColorType.primaryTextColor),
          fontSize: 13),
      decoration: InputDecoration(
          border: border(),
          enabledBorder: border(),
          focusedBorder: border(),
          labelText: labelText,
          labelStyle: regularStyle(
              color: textColor ?? EnhanceColors.color(ColorType.primaryTextColor),
              fontSize: 14),
          hintText: hintText,
          hintStyle: regularStyle(
              color: (calledInNavigationBottomSheet?EnhanceColors.color(ColorType.primary):EnhanceColors.color(ColorType.primaryTextColor))
                  .withOpacity(0.5)),
          suffixIcon: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  Icons.calendar_today,
                  color: EnhanceColors.color(calledInNavigationBottomSheet?ColorType.primary:ColorType.secondaryTextColor),
                ),
                onPressed: () {
                  selectDateFunction();
                },
              ),
              if (!dateOnly)
                Column(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.access_time,
                        color: EnhanceColors.color(calledInNavigationBottomSheet?ColorType.primary:ColorType.secondaryTextColor),
                      ),
                      onPressed: () {
                        selectTimeFunction();
                      },
                    )
                  ],
                )
            ],
          )),
    );
  }

  InputBorder border() {
    if (underLineTextField)
      return UnderlineInputBorder(
          borderSide:
              BorderSide(color: EnhanceColors.color(ColorType.secondary13)));
    else
      return OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: fullBorderColor == null
                ? EnhanceColors.color(ColorType.accent)
                : fullBorderColor,
          ));
  }
}
