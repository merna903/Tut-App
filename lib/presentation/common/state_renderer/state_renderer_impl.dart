import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_project/app/constants.dart';
import 'package:new_project/presentation/common/state_renderer/state_remderer.dart';
import 'package:new_project/presentation/resources/string_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();
}

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

class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

class SuccessState extends FlowState {
  String message;

  SuccessState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.popUpSuccessState;
}

class ContentState extends FlowState {

  ContentState();

  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;
}

class EmptyState extends FlowState {

  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.fullScreenEmptyState;
}

extension FlowStateExtention on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreen,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        if (getStateRendererType() == StateRendererType.popUpLoadingState) {
          showPopUp(context, getStateRendererType(), getMessage());
          return contentScreen;
        } else {
          return StateRenderer(
            massage: getMessage(),
            stateRendererType: getStateRendererType(),
            retryActionFunction: retryActionFunction,
          );
        }
      case ErrorState:
        dismissDialog(context);
        if (getStateRendererType() == StateRendererType.popUpErrorState) {
          showPopUp(context, getStateRendererType(), getMessage());
          return contentScreen;
        } else {
          return StateRenderer(
            massage: getMessage(),
            stateRendererType: getStateRendererType(),
            retryActionFunction: retryActionFunction,
          );
        }
      case SuccessState:
        dismissDialog(context);
        showPopUp(context, getStateRendererType(), getMessage(),title: AppStrings.success.tr());
        return contentScreen;
      case ContentState:
        dismissDialog(context);
        return contentScreen;
      case EmptyState:
        return StateRenderer(
          massage: getMessage(),
          stateRendererType: getStateRendererType(),
          retryActionFunction: () {},
        );
      default:
        dismissDialog(context);
        return contentScreen;
    }
  }

  dismissDialog(BuildContext context) {
    if (_isCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  _isCurrentDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  showPopUp(
      BuildContext context, StateRendererType stateRendererType, String message,
      {String title = Constants.empty}) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
        context: context,
        builder: (BuildContext context) => StateRenderer(
              stateRendererType: stateRendererType,
              retryActionFunction: () {},
              massage: message,
              title: title,
            )));
  }
}
