import 'package:advanced_flutter/App/app.dart';
import 'package:advanced_flutter/App/di.dart';
import 'package:advanced_flutter/presention/Resourses/language_manger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await initAppModule();
  runApp(EasyLocalization(
      supportedLocales: const [ARABIC_LOCALE, ENGLISH_LOCALE],
      path: AssetsPathLocalization,
      child: Phoenix(child: MyApp())));
}
