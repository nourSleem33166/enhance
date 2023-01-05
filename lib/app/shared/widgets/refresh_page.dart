import 'package:flutter/material.dart';

class RefreshPage extends StatelessWidget {
  Function refreshFunction;

  RefreshPage(this.refreshFunction);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: Icon(
          Icons.refresh,
          size: 30,
        ),
        onPressed: () {
          refreshFunction();
        },
      ),
    );
  }
}
