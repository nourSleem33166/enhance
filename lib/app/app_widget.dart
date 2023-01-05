import 'package:bot_toast/bot_toast.dart';
import 'package:enhance/app/app_controller.dart';
import 'package:enhance/app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:asuka/asuka.dart' as asuka;

class AppWidget extends StatefulWidget {
  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends ModularState<AppWidget, AppController> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return MaterialApp(
      navigatorKey: Modular.navigatorKey,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Enhance',
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        child = asuka.builder(context, child);
        child = botToastBuilder(context, child);
        return child;
      },
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
          accentColor: EnhanceColors.color(ColorType.secondary13),
          scaffoldBackgroundColor: Colors.white),
      initialRoute: '/splash',
      onGenerateRoute: Modular.generateRoute,
    );
  }
}
