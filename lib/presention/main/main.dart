import 'package:advanced_flutter/presention/Resourses/Strings.dart';
import 'package:advanced_flutter/presention/Resourses/ValuesManger.dart';
import 'package:advanced_flutter/presention/Resourses/colors.dart';
import 'package:advanced_flutter/presention/main/pages/home/home_page.dart';
import 'package:advanced_flutter/presention/main/pages/notifications/notfication_page.dart';
import 'package:advanced_flutter/presention/main/pages/search/search_page.dart';
import 'package:advanced_flutter/presention/main/pages/seeting/Setting_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}
var _title = AppStrings.home.tr();
var _currentIndex=0;
List<Widget> pages = const[
  HomePage(),
  SearchPage(),
  NotificationPage(),
  SettingPage()
];
List<String> title = [
  AppStrings.home.tr(),
  AppStrings.search.tr(),
  AppStrings.notification.tr(),
  AppStrings.setting.tr()
];


class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(_title,style: Theme.of(context).textTheme.titleSmall,) ,
      ),
      body: pages[_currentIndex],
      bottomNavigationBar:Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: ColorManger.lightGrey, spreadRadius: AppSize.s1)],
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: ColorManger.primary,
          unselectedItemColor: ColorManger.grey,
          currentIndex: _currentIndex,
          onTap: onTap,
          items:  [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: AppStrings.home.tr()),
            BottomNavigationBarItem(icon: Icon(Icons.search),label: AppStrings.search.tr()),
            BottomNavigationBarItem(icon: Icon(Icons.notifications),label: AppStrings.notification.tr()),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: AppStrings.setting.tr()),
          ],),
      ) ,
    );
  }

  onTap(int index){
    setState((){
      _currentIndex = index;
      _title=title[index];
    });
  }
}
