import 'package:enhance/app/shared/font_styles.dart';
import 'package:flutter/material.dart';

class SharedFlatButton extends StatelessWidget {
  bool isEnabled;

  String text;
  EdgeInsets padding;
  Function onPressed;
  Color textColor = Colors.black;

  SharedFlatButton(
      {@required this.text,
      @required this.onPressed,
      this.isEnabled = true,
      this.textColor,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: isEnabled ? onPressed : null,
      child: Text(
        text,
        style: regularStyle(color: textColor, fontSize: 16),
      ),
      padding: padding,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }
}
