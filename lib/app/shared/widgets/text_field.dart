import 'package:enhance/app/shared/colors.dart';
import 'package:enhance/app/shared/font_styles.dart';
import 'package:flutter/material.dart';

class SharedTextField extends StatelessWidget {
  TextEditingController controller;
  String labelText;
  String hintText;
  Function(String value) validator;
  Function (String value) onChanged;
  bool isTitle;
  IconData suffixIcon;
  bool obscureText;
  Color hintColor;
  bool underLineTextField;
  Color labelColor;
  Function suffixFunction;
  TextInputType textInputType;
  bool readOnly;
  bool isExpandable;
  Color textColor = EnhanceColors.color(ColorType.secondary);
  Color suffixIconColor = EnhanceColors.color(ColorType.labelColor);
  Color borderTextFieldColor;

  SharedTextField(
      {@required this.controller,
      this.validator,
        this.hintColor,this.onChanged,
      this.suffixFunction,this.isTitle=false,
        this.labelColor,
      this.textInputType = TextInputType.text,
      this.labelText,
      this.textColor,
      this.suffixIconColor,
      this.readOnly = false,
      this.isExpandable = false,
      this.hintText,
      this.suffixIcon,
      this.obscureText = false,
      this.borderTextFieldColor,
      this.underLineTextField = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        readOnly: readOnly,
        expands: isExpandable,onChanged: onChanged,
        maxLines: obscureText ? 1 : null,
        controller: controller,
        keyboardType: textInputType,
        cursorColor: EnhanceColors.color(ColorType.accent),
        obscureText: obscureText,
        style: isTitle?boldStyle(
            color: textColor == null
                ? EnhanceColors.color(ColorType.primaryTextColor)
                : textColor,
            fontSize: 13):regularStyle(
            color: textColor == null
                ? EnhanceColors.color(ColorType.primaryTextColor)
                : textColor,
            fontSize: 13),
        decoration: InputDecoration(
            border: border(),
            enabledBorder: border(),
            focusedBorder: border(),
            labelText: labelText,
            labelStyle: regularStyle(
                color: labelColor == null
                    ? EnhanceColors.color(ColorType.primaryTextColor)
                    : labelColor,
                fontSize: 18),
            hintText: hintText,
            hintStyle: regularStyle(
                color: hintColor==null?EnhanceColors.color(ColorType.secondaryTextColor).withOpacity(0.5):hintColor,),
            suffixIcon: suffixIcon != null
                ? IconButton(
                    icon: Icon(
                      suffixIcon,
                      color: suffixIconColor,
                    ),
                    onPressed: suffixFunction,
                  )
                : null),
        autovalidateMode: validator != null
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        validator: validator);
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
            color: borderTextFieldColor == null
                ? EnhanceColors.color(ColorType.secondary13)
                : borderTextFieldColor,
          ));
  }
}
