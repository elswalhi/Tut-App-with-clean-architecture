import 'package:advanced_flutter/App/di.dart';
import 'package:advanced_flutter/App/shared_pref.dart';
import 'package:advanced_flutter/presention/Resourses/ThemeManger.dart';
import 'package:advanced_flutter/presention/Resourses/routs%20manger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {

  const MyApp._internal();
  static const _instance =MyApp._internal();
  factory MyApp()=>_instance;


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  @override
  void didChangeDependencies() {
    _appPreferences.getLocale().then((local)=>{context.setLocale(local)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGeneretor.getRoute,
      initialRoute: Routs.splashRoute,
      theme: AppTheme(),
    );
  }
}
