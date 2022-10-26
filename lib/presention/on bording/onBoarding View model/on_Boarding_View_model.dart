import 'dart:async';

import 'package:advanced_flutter/domain/model/Models.dart';
import 'package:advanced_flutter/presention/Resourses/Strings.dart';
import 'package:advanced_flutter/presention/Resourses/assets%20manger.dart';
import 'package:advanced_flutter/presention/base/base_view_model.dart';
import 'package:easy_localization/easy_localization.dart';



class OnBoardingViewModel extends BaseViewModel with OnBoardingViewModelInput , OnBoardingViewModelOutput{

   final StreamController _streamController = StreamController<SliderViewObject>();
  // StreamController.stream.asBroadcastStream().listen(onData);
  late final List<SliderObject>  _list;
  int _currentPageIndex=0;



  @override
  void start() {
    _list=_getSliderData();
    _postDataToView();
  }

  @override
  void dispose() {
    _streamController.close();
  }


  @override
  int goPrevious() {
    int previousIndex=--_currentPageIndex;
    if(previousIndex==-1){
      previousIndex=_list.length-1;
    }
    return previousIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentPageIndex=index;
    _postDataToView();
  }

  @override
  // TODO: implement inputSliderViewObject
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  // TODO: implement outputSliderViewObject
  Stream<SliderViewObject> get outputSliderViewObject => _streamController.stream.map((sliderViewObject) => sliderViewObject);

  //onBoarding private function


  List<SliderObject> _getSliderData()=>[
    SliderObject(AppStrings.onBoardingSUBTitle1.tr(), AppStrings.onBoardingSUBTitle1.tr(), ImageAssets.onBoardingLogo1),
    SliderObject(AppStrings.onBoardingSUBTitle2.tr(), AppStrings.onBoardingSUBTitle2.tr(), ImageAssets.onBoardingLogo2),
    SliderObject(AppStrings.onBoardingSUBTitle3.tr(), AppStrings.onBoardingSUBTitle3.tr(), ImageAssets.onBoardingLogo3),
    SliderObject(AppStrings.onBoardingSUBTitle4.tr(), AppStrings.onBoardingSUBTitle4.tr(), ImageAssets.onBoardingLogo4),
  ];
  void _postDataToView(){
    inputSliderViewObject.add(SliderViewObject(_currentPageIndex,_list[_currentPageIndex], _list.length));
  }

  @override
  int goNext() {
    int nextIndex=++_currentPageIndex;
    if(nextIndex==_list.length){
    nextIndex=0;
    }
    return nextIndex;
  }
}
abstract class OnBoardingViewModelInput{
  int goNext();
  int goPrevious();
  void onPageChanged(int index);
  Sink get inputSliderViewObject;
}


abstract class OnBoardingViewModelOutput{
  Stream<SliderViewObject> get outputSliderViewObject;
}