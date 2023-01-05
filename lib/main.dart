import 'package:easy_localization/easy_localization.dart';
import 'package:enhance/app/app_module.dart';
import 'package:enhance/generated/codegen_loader.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'generated/locale_keys.g.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  print("Date ${DateTime.now()}");
  runApp(EasyLocalization(
      startLocale: Locale('en'),
      supportedLocales: [Locale('en'), Locale('ar')],
      saveLocale: true,
      useOnlyLangCode: true,
      path: 'translations',
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),
      child: ModularApp(module: AppModule())));
}
