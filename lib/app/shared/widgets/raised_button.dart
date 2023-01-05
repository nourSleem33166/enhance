import 'package:enhance/app/shared/font_styles.dart';
import 'package:flutter/material.dart';

class SharedRaisedButton extends StatelessWidget {
  bool isEnabled = true;
  String text;
  Color color;
  EdgeInsets padding;
  Function onPressed;

  SharedRaisedButton(
      {@required this.text,
      @required this.onPressed,
      this.isEnabled=true,
      this.color,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: isEnabled ? onPressed : null,
      child: Text(
        text,
        style: regularStyle(color: Colors.white, fontSize: 16),
      ),
      color: color,
      padding: padding,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
    );
  }
}
