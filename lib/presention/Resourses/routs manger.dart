import 'package:advanced_flutter/App/di.dart';
import 'package:advanced_flutter/presention/REgister/view/Register.dart';
import 'package:advanced_flutter/presention/Resourses/Strings.dart';
import 'package:advanced_flutter/presention/forget_password/forget%20pass.dart';
import 'package:advanced_flutter/presention/login/view/login.dart';
import 'package:advanced_flutter/presention/main/main.dart';
import 'package:advanced_flutter/presention/on%20bording/On%20Boarding%20View/on%20bording.dart';
import 'package:advanced_flutter/presention/splash%20screen/splash.dart';
import 'package:advanced_flutter/presention/store_details/details.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class Routs{
  static const String splashRoute="/";
  static const String loginRoute="/login";
  static const String registerRoute="/register";
  static const String forgetPasswordRoute="/forgetPassword";
  static const String onBoardingRoute="/onBoarding";
  static const String mainRoute="/main";
  static const String storeDetailsRoute="/storeDetails";
}
class RouteGeneretor {

  static Route<dynamic> getRoute(RouteSettings settings){
    switch (settings.name) {
      case Routs.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routs.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnBoarding());
      case Routs.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routs.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routs.forgetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordView());
      case Routs.mainRoute:
        initHomeModule();

        return MaterialPageRoute(builder: (_) => const MainView());
      case Routs.storeDetailsRoute:
        initStoreDetailsModule();
        return MaterialPageRoute(builder: (_) => const StoreDetailsView());
      default :
        return unDefinedRoute();
    }
    }
    static Route<dynamic> unDefinedRoute(){
    return MaterialPageRoute(builder: (_)=> Scaffold(
       appBar: AppBar(
        title:   Text(AppStrings.noRouteFound.tr()),
      ),
      body:   Center(child: Text(AppStrings.noRouteFound.tr())),
    ));
    }
}
