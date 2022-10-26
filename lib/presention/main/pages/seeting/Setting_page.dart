import 'package:advanced_flutter/App/di.dart';
import 'package:advanced_flutter/App/shared_pref.dart';
import 'package:advanced_flutter/data/Data_source/local_data_source.dart';
import 'package:advanced_flutter/presention/Resourses/Strings.dart';
import 'package:advanced_flutter/presention/Resourses/ValuesManger.dart';
import 'package:advanced_flutter/presention/Resourses/routs%20manger.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();
  @override
  Widget build(BuildContext context) {
    return Center(child:ListView(
      padding: const EdgeInsets.all(AppPadding.p8),
      children: [
        ListTile(
          title:Text(AppStrings.changeLanguage.tr(),style: Theme.of(context).textTheme.bodyLarge,) ,
          leading:const Icon(Icons.language),
          trailing:const Icon(Icons.arrow_forward_ios) ,
          onTap: (){
            _changeLanguage();
          },
        ),
        ListTile(
          title:Text(AppStrings.contactUs.tr(),style: Theme.of(context).textTheme.bodyLarge,) ,
          leading:const Icon(Icons.contacts),
          trailing:const Icon(Icons.arrow_forward_ios) ,
          onTap: (){},
        ),
        ListTile(
          title:Text(AppStrings.invite.tr(),style: Theme.of(context).textTheme.bodyLarge,) ,
          leading:const Icon(Icons.share),
          trailing:const Icon(Icons.arrow_forward_ios) ,
          onTap: (){},
        ),
        ListTile(
          title:Text(AppStrings.logOut.tr(),style: Theme.of(context).textTheme.bodyLarge,) ,
          leading:const Icon(Icons.logout),
          trailing:const Icon(Icons.arrow_forward_ios) ,
          onTap: (){
            _logOut();
          },
        ),
      ],
    ));
  }
  _changeLanguage(){
    _appPreferences.changeAppLanguage();
    Phoenix.rebirth(context);
  }
  _logOut(){
    Navigator.pushReplacementNamed(context, Routs.loginRoute);
    _appPreferences.logOut();
    _localDataSource.clearCache();
  }
}
