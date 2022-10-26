import 'package:advanced_flutter/App/di.dart';
import 'package:advanced_flutter/App/shared_pref.dart';
import 'package:advanced_flutter/domain/model/Models.dart';
import 'package:advanced_flutter/presention/Resourses/Strings.dart';
import 'package:advanced_flutter/presention/Resourses/ValuesManger.dart';
import 'package:advanced_flutter/presention/Resourses/assets%20manger.dart';
import 'package:advanced_flutter/presention/Resourses/colors.dart';
import 'package:advanced_flutter/presention/Resourses/constance.dart';
import 'package:advanced_flutter/presention/Resourses/routs%20manger.dart';
import 'package:advanced_flutter/presention/on%20bording/onBoarding%20View%20model/on_Boarding_View_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController();
  final OnBoardingViewModel _viewModel =OnBoardingViewModel();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  void _bind(){
    _appPreferences.setOnBoardingScreenViewed();
    _viewModel.start();
  }
  @override
  void initState() {
    _bind();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
        builder: (context,snapshot){
        return _getContentWidget(snapshot.data);
        });
  }
  Widget _getContentWidget(SliderViewObject? sliderViewObject){
    if(
    sliderViewObject == null
    ){
      return const Center(child: Text("NO DATA"));
    }
    else{
    return Scaffold(
      backgroundColor: ColorManger.white,
      appBar: AppBar(
        systemOverlayStyle:  SystemUiOverlayStyle(
          statusBarColor: ColorManger.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: AppSize.s0,
        backgroundColor: ColorManger.white,
      ),
      body:PageView.builder(itemBuilder:(context,index) =>OnBoardingPage(sliderViewObject.sliderObject),
        onPageChanged: (index){
        _viewModel.onPageChanged(index);
        },
        itemCount: sliderViewObject.numOfSlides,
        controller:_pageController ,),

      bottomSheet: Container(
        color: ColorManger.white,
        height: AppSize.s100,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(child:  Text(AppStrings.skip.tr(),textAlign:TextAlign.end ,style: Theme.of(context).textTheme.titleMedium,),onPressed: (){
                Navigator.pushReplacementNamed(context, Routs.loginRoute);
              },),
            ),
            _getBottomSheetWidget(sliderViewObject),
          ],
        ),
      ),
    );
  }

  }
  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject){
    return Container(
      height: AppSize.s52,
      color: ColorManger.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //left Arrow,
          if(sliderViewObject.currentIndex !=0)
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p20),
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.onBoardingLeftArrow),
              ),
            ),
            onTap: (){
             _pageController.animateToPage(_viewModel.goPrevious(), duration:const  Duration(milliseconds: AppConstants.sliderDelay) , curve: Curves.bounceOut);
            },
          ),
          if(sliderViewObject.currentIndex==0)
            const Padding(
              padding: EdgeInsets.all(AppPadding.p14),
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
              ),
            ),
          const Spacer()
          ,Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for(int i = 0 ; i < sliderViewObject.numOfSlides ; i++)
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: _getPropperCircle(i,sliderViewObject.currentIndex),
                  )
              ],
            ),
          ),
          const Spacer(),

          // Right Arrow
          if(sliderViewObject.currentIndex!=sliderViewObject.numOfSlides-1)
            InkWell(
              child: Padding(
              padding: const EdgeInsets.all(AppPadding.p20),
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.onBoardingRightArrow),
              ),
          ),
              onTap: () {
                _pageController.animateToPage(_viewModel.goNext(),
                    duration: const Duration(
                        milliseconds: AppConstants.sliderDelay),
                    curve: Curves.bounceOut);
              },
            ),
          if(sliderViewObject.currentIndex ==sliderViewObject.numOfSlides-1)
            const Padding(
              padding: EdgeInsets.all(AppPadding.p14),
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
              ),
            ),

        ],
      ),
    );

  }

  Widget _getPropperCircle(int index,int currentIndex){
    if (index==currentIndex){
      return SvgPicture.asset(ImageAssets.onBoardingCircle);

    }
    else{
      return SvgPicture.asset(ImageAssets.onBoardingSolidCircle);

    }
  }
  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;
   const OnBoardingPage(this._sliderObject,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:AppPadding.p70),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: AppSize.s40,),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Text(_sliderObject.title,textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Text(_sliderObject.subTitle,textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,),
          ),
           const SizedBox(height: AppSize.s60,),
          SvgPicture.asset(_sliderObject.image),
        ],
      ),
    );

  }
}
