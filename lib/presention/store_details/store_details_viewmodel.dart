import 'dart:async';
import 'dart:ffi';

import 'package:advanced_flutter/domain/model/Models.dart';
import 'package:advanced_flutter/domain/usecase/storeDetailsUseecase.dart';
import 'package:advanced_flutter/presention/base/base_view_model.dart';
import 'package:advanced_flutter/presention/common/state_render/state_render.dart';
import 'package:advanced_flutter/presention/common/state_render/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';


  class StoreDetailsViewModel extends BaseViewModel
    with StoreDetailsViewModelInput, StoreDetailsViewModelOutput {
  final _storeDetailsStreamController = BehaviorSubject<StoreDetails>();

  final StoreDetailsUseCase storeDetailsUseCase;

  StoreDetailsViewModel(this.storeDetailsUseCase);

  @override
  start() async {
    _loadData();
  }

  _loadData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.FULLSCREEN_LOADING_STATE));
    (await storeDetailsUseCase.execute(Void)).fold(
          (failure) {
        inputState.add(ErrorState(
            StateRendererType.FULLSCREEN_ERROR_STATE, failure.message));

      },
          (storeDetails) async {
        inputState.add(ContentState());
        inputStoreDetails.add(storeDetails);
      },
    );
  }

  @override
  void dispose() {
    _storeDetailsStreamController.close();
  }

  @override
  Sink get inputStoreDetails => _storeDetailsStreamController.sink;

  //output
  @override
  Stream<StoreDetails> get outputStoreDetails =>
      _storeDetailsStreamController.stream.map((stores) => stores);
}

abstract class StoreDetailsViewModelInput {
  Sink get inputStoreDetails;
}

abstract class StoreDetailsViewModelOutput {
  Stream<StoreDetails> get outputStoreDetails;
}