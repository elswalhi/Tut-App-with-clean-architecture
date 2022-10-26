import 'dart:async';
import 'dart:ffi';

import 'package:advanced_flutter/domain/model/Models.dart';
import 'package:advanced_flutter/domain/usecase/Home_usecase.dart';
import 'package:advanced_flutter/presention/Resourses/Strings.dart';
import 'package:advanced_flutter/presention/base/base_view_model.dart';

import 'package:advanced_flutter/presention/common/state_render/state_render.dart';
import 'package:advanced_flutter/presention/common/state_render/state_renderer_impl.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
//
// class HomeViewModel extends BaseViewModel with HomeViewModelInput , HomeViewModelOutput{
//   final HomeUseCase _homeUseCase;
//   HomeViewModel(this._homeUseCase);
//   final StreamController _bannersStreamController =
//       BehaviorSubject<List<BannerAd>>();
//   final StreamController _servicesStreamController =
//       BehaviorSubject<List<Service>>();
//   final StreamController _storeStreamController =
//       BehaviorSubject<List<Store>>();
//   @override
//   void start() {
//     _getHomeData();
//   }
//   _getHomeData()async{
//
//     inputState.add(LoadingState(stateRendererType: StateRendererType.FULLSCREEN_LOADING_STATE,message: AppStrings.loading));
//     (await _homeUseCase.execute(Void))
//         .fold(
//     (failure){
//     print(failure.code);
//     inputState.add(ErrorState(StateRendererType.FULLSCREEN_ERROR_STATE, failure.message));
//   },
//     (homeObject){
//     inputState.add(ContentState());
//     inputBanners.add(homeObject.data.banner);
//     inputServices.add(homeObject.data.service);
//     inputStore.add(homeObject.data.store);
//     // isUserLoginStreamController.add(true);
//     });
//   }
//
//
//   @override
//   void dispose() {
//     _servicesStreamController.close();
//     _bannersStreamController.close();
//     _storeStreamController.close();
//     super.dispose();
//   }
//
//   @override
//   Sink get inputBanners => _bannersStreamController.sink;
//
//   @override
//   Sink get inputServices => _servicesStreamController.sink;
//
//   @override
//   Sink get inputStore =>_storeStreamController.sink;
//
//   // output
//
//   @override
//   Stream<List<BannerAd>> get outputBanners => _bannersStreamController.stream.map((banners) => banners);
//
//   @override
//   Stream<List<Service>> get outputService => _servicesStreamController.stream.map((service) => service);
//
//   @override
//   Stream<List<Store>> get outputStore => _storeStreamController.stream.map((store) => store);
// }
//
// abstract class HomeViewModelInput{
//   Sink get inputStore;
//   Sink get inputServices;
//   Sink get inputBanners;
//
// }
// abstract class HomeViewModelOutput{
//   Stream<List<Store>> get outputStore;
//   Stream<List<Service>> get outputService;
//   Stream<List<BannerAd>> get outputBanners;
// }


import 'dart:async';
import 'dart:ffi';


import 'package:rxdart/rxdart.dart';


class HomeViewModel extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  final _dataStreamController = BehaviorSubject<HomeViewObject>();

  final HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);

  // --  inputs
  @override
  void start() {
    _getHomeData();
  }

  _getHomeData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULLSCREEN_LOADING_STATE));
    (await _homeUseCase.execute(Void)).fold(
            (failure) => {
          // left -> failure
          inputState.add(ErrorState(
              StateRendererType.FULLSCREEN_ERROR_STATE, failure.message))
        }, (homeObject) {
      // right -> data (success)
      // content
      inputState.add(ContentState());
      inputHomeData.add(HomeViewObject(homeObject.data.stores, homeObject.data.services, homeObject.data.banners));
      // navigate to main screen
    });
  }

  @override
  void dispose() {
    _dataStreamController.close();
    super.dispose();
  }

  @override
  Sink get inputHomeData => _dataStreamController.sink;

  // -- outputs
  @override
  Stream<HomeViewObject> get outputHomeData =>
      _dataStreamController.stream.map((data) => data);
}

abstract class HomeViewModelInput {
  Sink get inputHomeData;
}

abstract class HomeViewModelOutput {
  Stream<HomeViewObject> get outputHomeData;
}

class HomeViewObject {
  List<Store> stores;
  List<Service> services;
  List<BannerAd> banners;

  HomeViewObject(this.stores, this.services, this.banners);
}
