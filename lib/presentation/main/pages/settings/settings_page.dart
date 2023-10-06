import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_project/app/app_refrances.dart';
import 'package:new_project/app/di.dart';
import 'package:new_project/data/data_source/local_data_source.dart';
import 'package:new_project/presentation/resources/assets_manager.dart';
import 'package:new_project/presentation/resources/color_manager.dart';
import 'package:new_project/presentation/resources/routes_manager.dart';
import 'package:new_project/presentation/resources/string_manager.dart';
import 'package:new_project/presentation/resources/styles_manager.dart';
import 'package:new_project/presentation/resources/values_manager.dart';

class SettingsPge extends StatefulWidget {
  const SettingsPge({super.key});

  @override
  State<SettingsPge> createState() => _SettingsPgeState();
}

class _SettingsPgeState extends State<SettingsPge> {

  AppPreferences appPreferences = instance<AppPreferences>();
  LocalDataSource localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView(
          padding: const EdgeInsets.all(AppPadding.p8),
          children: [
            ListTile(
              leading: SvgPicture.asset(ImageAssets.changeLang),
              title: Text(AppStrings.changeLanguage.tr(),style: getRegularStyle(color: ColorManger.gray1),),
              trailing: SvgPicture.asset(ImageAssets.settingsRightArrow),
              onTap: ()
              {
                _changeLanguage();
              },
            ),
            ListTile(
              leading: SvgPicture.asset(ImageAssets.contactUs),
              title: Text(AppStrings.contactUs.tr(),style: getRegularStyle(color: ColorManger.gray1),),
              trailing: SvgPicture.asset(ImageAssets.settingsRightArrow),
              onTap: ()
              {
                _contactUs();
              },
            ),
            ListTile(
              leading: SvgPicture.asset(ImageAssets.inviteFriends),
              title: Text(AppStrings.inviteYourFriends.tr(),style: getRegularStyle(color: ColorManger.gray1),),
              trailing: SvgPicture.asset(ImageAssets.settingsRightArrow),
              onTap: (){
                _inviteFriends();
              },
            ),
            ListTile(
              leading: SvgPicture.asset(ImageAssets.logOut),
              title: Text(AppStrings.logOut.tr(),style: getRegularStyle(color: ColorManger.gray1),),
              trailing: SvgPicture.asset(ImageAssets.settingsRightArrow),
              onTap: ()
              {
                _logOut();
              },
            ),
          ],
        )
    );
  }

  void _changeLanguage()
  {
    appPreferences.setAppLanguage();
    Phoenix.rebirth(context);
  }

  void _contactUs() {}

  void _inviteFriends() {}

  void _logOut() {
    appPreferences.logOut();
    localDataSource.clearCache();
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}
