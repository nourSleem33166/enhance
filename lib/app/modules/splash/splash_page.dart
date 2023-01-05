import 'package:enhance/app/modules/splash/splash_controller.dart';
import 'package:enhance/app/shared/colors.dart';
import 'package:enhance/app/shared/font_styles.dart';
import 'package:enhance/app/shared/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:enhance/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends ModularState<SplashPage, SplashController> {
  @override
  void initState() {
    super.initState();
    controller.navigateHomeOrLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/shared/enhance_logo.png",
              width: 150,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              LocaleKeys.app.tr(),
              style: boldStyle(
                  fontSize: 25,
                  color: EnhanceColors.color(ColorType.secondary13)),
            ),
            SizedBox(
              height: 30,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.gettingThingsReady.tr(),
                  style: regularStyle(
                      fontSize: 14,
                      color: EnhanceColors.color(ColorType.secondary13)),
                ),
                SizedBox(
                  width: 15,
                ),
                SizedBox(
                  child: Loading(),
                  height: 18,
                  width: 18,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
