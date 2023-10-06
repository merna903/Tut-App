import 'dart:async';
import 'dart:ffi';

import 'package:new_project/domain/models.dart';
import 'package:new_project/domain/use_case/home_use_case.dart';
import 'package:new_project/presentation/base/base_view_model.dart';
import 'package:new_project/presentation/common/state_renderer/state_remderer.dart';
import 'package:new_project/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel
    with HomeViewModelInput, HomeViewModelOutput {
  final StreamController _homeStreamController =
      BehaviorSubject<HomeViewObject>();

  final HomeUseCase _homeUseCase;

  HomeViewModel(this._homeUseCase);

  @override
  void start() {
    _getHomeData();
  }

  @override
  void dispose() {
    _homeStreamController.close();
    super.dispose();
  }

  _getHomeData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));
    // ignore: void_checks
    (await _homeUseCase.execute(Void)).fold(
        (failure) => {
              inputState.add(ErrorState(
                  StateRendererType.fullScreenErrorState, failure.message))
            }, (home) {
      inputState.add(ContentState());
      inputHomeData.add(HomeViewObject(home.data!.service,home.data!.banner,home.data!.store));
    });
  }
  @override
  Sink get inputHomeData => _homeStreamController.sink;

  @override
  Stream<HomeViewObject> get outHomeData => _homeStreamController.stream.map((homeData) => homeData);
}

abstract class HomeViewModelInput {
  Sink get inputHomeData;
}

abstract class HomeViewModelOutput {
  Stream<HomeViewObject> get outHomeData;
}

class HomeViewObject {
  List<Services> services;
  List<Banners> banners;
  List<Stores> stores;
  HomeViewObject(this.services,this.banners,this.stores);
}