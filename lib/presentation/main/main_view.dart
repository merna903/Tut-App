import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:new_project/app/constants.dart';
import 'package:new_project/presentation/main/pages/home/home_page.dart';
import 'package:new_project/presentation/main/pages/notification/notification_page.dart';
import 'package:new_project/presentation/main/pages/search/search_page.dart';
import 'package:new_project/presentation/main/pages/settings/settings_page.dart';
import 'package:new_project/presentation/resources/color_manager.dart';
import 'package:new_project/presentation/resources/string_manager.dart';
import 'package:new_project/presentation/resources/styles_manager.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const NotificationPage(),
    const SettingsPge(),
  ];
  List<String> titles = [
    AppStrings.home.tr(),
    AppStrings.search.tr(),
    AppStrings.notification.tr(),
    AppStrings.settings.tr()
  ];

  var _title = AppStrings.home.tr();
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          _title,
          style: getMediumStyle(color: ColorManger.white),
        )),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: ColorManger.gray, spreadRadius: 0.5)]),
        child: BottomNavigationBar(
          selectedItemColor: ColorManger.primary,
          unselectedItemColor: ColorManger.gray,
          currentIndex: _currentIndex,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: Constants.empty),
            BottomNavigationBarItem(icon: Icon(Icons.search_outlined),label: Constants.empty),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_none_outlined),label: Constants.empty),
            BottomNavigationBarItem(icon: Icon(Icons.settings_outlined),label: Constants.empty),
          ],
        ),
      ),
    );
  }

  onTap(int index) {
    setState(() {
      _currentIndex = index;
      _title = titles[index];
    });
  }
}
