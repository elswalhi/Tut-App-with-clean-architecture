import 'dart:async';

import 'package:advanced_flutter/App/di.dart';
import 'package:advanced_flutter/App/shared_pref.dart';
import 'package:advanced_flutter/presention/Resourses/assets%20manger.dart';
import 'package:advanced_flutter/presention/Resourses/colors.dart';
import 'package:advanced_flutter/presention/Resourses/constance.dart';
import 'package:advanced_flutter/presention/Resourses/routs%20manger.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();
  _startDelay(){
    _timer= Timer( const Duration(seconds: AppConstants.splashDelay), _goNext);
  }
  _goNext(){
    _appPreferences.isLoginScreenViewed().then((isUserLoggedIn){
      if(isUserLoggedIn){
        Navigator.pushReplacementNamed(context,Routs.mainRoute );
      }else{
        _appPreferences.isOnBoardingScreenViewed().then((isUserSeeOnBoarding){
          if(isUserSeeOnBoarding){
            Navigator.pushReplacementNamed(context,Routs.loginRoute );
          }
          else{
            Navigator.pushReplacementNamed(context,Routs.onBoardingRoute );

          }
        });
      }
    });
  }
  @override
  void initState() {
    super.initState();
    _startDelay();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.primary,
      body: const Center(child: Image(image: AssetImage(ImageAssets.splashLogo),)),
    );
  }
  @override
  void dispose() {
_timer?.cancel();
super.dispose();
  }
}
