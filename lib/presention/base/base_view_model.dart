import 'dart:async';

import 'package:advanced_flutter/presention/base/base_view_model.dart';
import 'package:advanced_flutter/presention/common/state_render/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInput with BaseViewModelOutput{
  //shared var and functions
final StreamController _inputStreamController=StreamController<FlowState>.broadcast();
@override
  void dispose() {
    _inputStreamController.close();
  }

  @override
  Sink get inputState => _inputStreamController.sink;

@override
  Stream<FlowState> get outputState => _inputStreamController.stream.map((flowState) => flowState);
}
//input
abstract class BaseViewModelInput{
  void start(); // start view model job

  void dispose();
  // will be called when view model diss
Sink get inputState;
}


abstract class BaseViewModelOutput{
  // will be implemented later xD
  Stream<FlowState> get outputState;
}

