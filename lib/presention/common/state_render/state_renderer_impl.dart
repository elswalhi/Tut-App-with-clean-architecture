import 'package:advanced_flutter/App/constance.dart';
import 'package:advanced_flutter/presention/Resourses/Strings.dart';
import 'package:advanced_flutter/presention/common/state_render/state_render.dart';
import 'package:flutter/material.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();
  String getMessage();
}

// loading state
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  LoadingState(
      {required this.stateRendererType, this.message = AppStrings.loading});
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

//error state
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  ErrorState(this.stateRendererType, this.message);
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// content state
class ContentState extends FlowState {
  @override
  String getMessage() => Constance.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.CONTENT_STATE;
}

//empty state
class EmptyState extends FlowState {
  String message;
  EmptyState(this.message);
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.FULLSCREEN_EMPTY_STATE;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(
      BuildContext context, Widget contentScreenWidget, Function retryAction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.POPUP_LOADING_STATE) {
            showPopup(context, getStateRendererType(), getMessage());
            return contentScreenWidget;
          } else {
            return StateRenderer(
              message: getMessage(),
              stateRendererType: getStateRendererType(),
              retryAction: retryAction,
            );
          }
        }
      case ErrorState:
        {
          dismissDialog(context);
          if (getStateRendererType() == StateRendererType.POPUP_ERROR_STATE) {
            dismissDialog(context);
            showPopup(context, getStateRendererType(), getMessage());
            return contentScreenWidget;
          } else {
            dismissDialog(context);
            return StateRenderer(
              message: getMessage(),
              stateRendererType: getStateRendererType(),
              retryAction: retryAction,
            );
          }        }
      case EmptyState:
        {
          return StateRenderer(
            stateRendererType: getStateRendererType(),
            retryAction: () {},
            message: getMessage(),
          );
        }
      case ContentState:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
      default:
        {
          dismissDialog(context);
          return contentScreenWidget;
        }
    }
  }
  _isCurrentDialogShowing(context)=>ModalRoute.of(context)?.isCurrent !=true;

  dismissDialog(context){
    if(_isCurrentDialogShowing(context)){
      Navigator.of(context,rootNavigator: true).pop(true);
    }
  }

  showPopup(BuildContext context, StateRendererType stateRendererType,
      String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (context) => StateRenderer(
            stateRendererType: stateRendererType, retryAction: () {}, message: message,)));
  }
}
