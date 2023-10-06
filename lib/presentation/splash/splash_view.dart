import 'dart:async';

import 'package:flutter/material.dart';
import 'package:new_project/app/app_refrances.dart';
import 'package:new_project/app/di.dart';
import 'package:new_project/presentation/resources/assets_manager.dart';
import 'package:new_project/presentation/resources/color_manager.dart';
import 'package:new_project/presentation/resources/constants_manager.dart';
import 'package:new_project/presentation/resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();


  _startDelay(){
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay),_goNext);
  }

  _goNext() {
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) => {
          if (isUserLoggedIn)
            {Navigator.pushReplacementNamed(context, Routes.mainRoute)}
          else
            {
              _appPreferences.isUserRegistered().then((isUserRegistered) => {
                    if (isUserRegistered)
                      {
                        Navigator.pushReplacementNamed(
                            context, Routes.mainRoute)
                      }
                    else
                      {
                        _appPreferences
                            .isOnBoardingScreenViewed()
                            .then((isOnBoardingScreenViewed) => {
                                  if (isOnBoardingScreenViewed)
                                    {
                                      Navigator.pushReplacementNamed(
                                          context, Routes.loginRoute)
                                    }
                                  else
                                    {
                                      Navigator.pushReplacementNamed(
                                          context, Routes.onBoardingRoute)
                                    }
                                })
                      }
                  })
            }
        });
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.primary,
      body: const Center(
        child: Image(
          image: AssetImage(ImageAssets.splashLogo),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
