import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_project/app/app_refrances.dart';
import 'package:new_project/app/di.dart';
import 'package:new_project/domain/models.dart';
import 'package:new_project/presentation/onboarding/viewmodel/onBoarding_viewmodel.dart';
import 'package:new_project/presentation/resources/assets_manager.dart';
import 'package:new_project/presentation/resources/color_manager.dart';
import 'package:new_project/presentation/resources/constants_manager.dart';
import 'package:new_project/presentation/resources/routes_manager.dart';
import 'package:new_project/presentation/resources/string_manager.dart';
import 'package:new_project/presentation/resources/values_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {

  final PageController _pageController = PageController();
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  _bind(){
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
    return sliderViewObject != null ? Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManger.white,
          statusBarBrightness: Brightness.dark,
        ),
        backgroundColor: ColorManger.white,
        elevation: 0.0,
      ),
      body: PageView.builder(
        itemBuilder: (context,index){
          return OnBoardingPage(sliderViewObject.sliderObject);
        },
        onPageChanged: (index){
          _viewModel.onPageChanged(index);
        },
        controller: _pageController,
        itemCount: sliderViewObject.numOfSlides,
      ),
      bottomSheet: Container(
        color: ColorManger.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: (){
                  Navigator.pushReplacementNamed(context, Routes.loginRoute);
                },
                child: Text(
                  AppStrings.skip.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.end,
                ),
              ),
            ),
            _getBottomSheetWidget(sliderViewObject),
          ],
        ),
      ),
    ) : Container();
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject){
    return Container(
      color: ColorManger.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                width: AppSize.z20,
                height: AppSize.z20,
                child: SvgPicture.asset(ImageAssets.leftArrow),
              ),
              onTap: (){
                _pageController.animateToPage(
                    _viewModel.goPrevious(),
                    duration: const Duration(milliseconds: AppConstants.sliderAnimationTime),
                    curve: Curves.bounceInOut
                );
              },
            ),
          ),
          Row(
            children: [
              for(int i=0; i<sliderViewObject.numOfSlides;i++)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i, sliderViewObject.currentIndex),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                width: AppSize.z20,
                height: AppSize.z20,
                child: SvgPicture.asset(ImageAssets.rightArrow),
              ),
              onTap: (){
                _pageController.animateToPage(
                    _viewModel.goNext(),
                    duration: const Duration(milliseconds: AppConstants.sliderAnimationTime),
                    curve: Curves.bounceInOut
                );
              }
            ),
          ),
        ],
      ),
    );
  }

  Widget _getProperCircle(int index,int currentPage){
    if(index == currentPage) {
      return SvgPicture.asset(ImageAssets.hollowCircle);
    } else {
      return SvgPicture.asset(ImageAssets.solidCircle);
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
  const OnBoardingPage(this._sliderObject,{super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.z40),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(_sliderObject.title.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(_sliderObject.subTitle.tr(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(height: AppSize.z60),
        SvgPicture.asset(_sliderObject.image),
      ],
    );
  }
}
