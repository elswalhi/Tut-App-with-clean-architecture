// ignore_for_file: constant_identifier_names, must_be_immutable

import 'package:advanced_flutter/presention/Resourses/Strings.dart';
import 'package:advanced_flutter/presention/Resourses/ValuesManger.dart';
import 'package:advanced_flutter/presention/Resourses/assets%20manger.dart';
import 'package:advanced_flutter/presention/Resourses/colors.dart';
import 'package:advanced_flutter/presention/Resourses/fontManger.dart';
import 'package:advanced_flutter/presention/Resourses/style_manger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType {
  // pop up state
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,

  //FULL SCREEN
  FULLSCREEN_LOADING_STATE,
  FULLSCREEN_ERROR_STATE,
  FULLSCREEN_EMPTY_STATE,
  //GENERAL
  CONTENT_STATE
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function retryAction;

  StateRenderer(
      {required this.stateRendererType,
      this.message = AppStrings.loading,
      this.title = "",
      required this.retryAction});

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(context) {
    switch (stateRendererType) {
      case StateRendererType.POPUP_LOADING_STATE:
        return _getPopUpDialog(context,[
          _getAnimatedImage(JsonAssets.loading),
          _getMessage(message),
        ]);
      case StateRendererType.POPUP_ERROR_STATE:
        return _getPopUpDialog(context,[
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryAgain(AppStrings.ok,context)
        ]);
      case StateRendererType.FULLSCREEN_LOADING_STATE:
        return _getItemsColumn( [
          _getAnimatedImage(JsonAssets.loading)
        ]);
      case StateRendererType.FULLSCREEN_ERROR_STATE:
        return _getItemsColumn( [
          _getAnimatedImage(JsonAssets.error),
          _getMessage(message),
          _getRetryAgain(AppStrings.ok, context)
        ]);
      case StateRendererType.FULLSCREEN_EMPTY_STATE:
        return _getItemsColumn([
          _getAnimatedImage(JsonAssets.empty),
          _getMessage(message)
        ]);
      case StateRendererType.CONTENT_STATE:
        return Container();
      default:
        return Container();

    }
  }
  Widget XD(){
    return Container(
      height: 300,
      width: double.infinity,
      color: Colors.white,
    );
  }
  Widget _getPopUpDialog(BuildContext context,List<Widget> children){
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s14)),
      elevation: AppSize.sBorder,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(color: ColorManger.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: const [BoxShadow(color: Colors.black26)]
        ),
        child: _getDialogContent(context,children),
      ),
    );
  }
  Widget _getDialogContent(BuildContext context,List<Widget> children){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
  Widget _getItemsColumn(List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName),
    );
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Text(
          message,
          style: RegularStyle(color: ColorManger.black, fontsize: Fontsize.s17),
        ),
      ),
    );
  }

  Widget _getRetryAgain(String buttonTitle,context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p18),
        child: SizedBox(
          width: double.infinity,
            child: ElevatedButton(onPressed: () {
              if(stateRendererType==StateRendererType.FULLSCREEN_ERROR_STATE){
                retryAction.call();
              }
              else{
                Navigator.pop(context);
              }
            }, child: Text(buttonTitle))),
      ),
    );
  }
}
