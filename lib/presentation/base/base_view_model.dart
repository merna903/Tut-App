import 'dart:async';

import 'package:new_project/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  final StreamController _streamController = BehaviorSubject<FlowState>();

  @override
  void dispose() {
    _streamController.close();
  }
  @override
  Sink get inputState => _streamController.sink;
  
  @override
  Stream<FlowState> get outputState => _streamController.stream.map((flowState) => flowState);
}

abstract class BaseViewModelInputs {
  void start();

  void dispose();

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
