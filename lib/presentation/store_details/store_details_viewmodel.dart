import 'dart:async';
import 'dart:ffi';

import 'package:new_project/domain/models.dart';
import 'package:new_project/domain/use_case/store_details_use_case.dart';
import 'package:new_project/presentation/base/base_view_model.dart';
import 'package:new_project/presentation/common/state_renderer/state_remderer.dart';
import 'package:new_project/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class StoreDetailsViewModel extends BaseViewModel
    with StoreDetailsViewModelInput, StoreDetailsViewModelOutput {
  final _storeDetailsStreamController = BehaviorSubject<StoreDetails>();

  final StoreDetailsUseCase storeDetailsUseCase;

  StoreDetailsViewModel(this.storeDetailsUseCase);

  @override
  void start() {
    _getStoreDetails();
  }

  @override
  void dispose() {
    _storeDetailsStreamController.close();
    super.dispose();
  }

  _getStoreDetails() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    // ignore: void_checks
    (await storeDetailsUseCase.execute(Void)).fold(
          (failure) {
        inputState.add(ErrorState(
            StateRendererType.fullScreenErrorState, failure.message));
      },
          (storeDetails) async {
        inputState.add(ContentState());
        inputStoreDetailsData.add(storeDetails);
      },
    );
  }

  @override
  Sink get inputStoreDetailsData => _storeDetailsStreamController.sink;

  @override
  Stream<StoreDetails> get outStoreDetailsData =>
      _storeDetailsStreamController.stream.map((details) => details);
}

abstract class StoreDetailsViewModelInput {
  Sink get inputStoreDetailsData;
}

abstract class StoreDetailsViewModelOutput {
  Stream<StoreDetails> get outStoreDetailsData;
}
