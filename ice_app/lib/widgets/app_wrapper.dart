import 'package:flutter/material.dart';
import 'package:ice_app/constants/app_constants.dart';
import 'package:ice_app/modules/dashboard/screens/dashboard_ui.dart';
import 'package:ice_app/modules/launch/screens/launch_ui.dart';
import 'package:ice_app/modules/profile/screens/profile_ui.dart';
import 'package:ice_app/modules/statistics/screens/statistics_ui.dart';
import 'package:ice_app/modules/workers/screens/workers_ui.dart';

class AppWrapper extends StatefulWidget {
  const AppWrapper({Key? key}) : super(key: key);

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  int currentIndex = 2;
  final screens = const [ Launch(), Statistics(), Dashboard(), Workers(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        centerTitle: true,
        leading: Image.asset('assets/images/ice_logo_dark.png'),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState((() => currentIndex = index)),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.cloud_upload_outlined),
                label: 'Lançamento',
                backgroundColor: PrimaryColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.area_chart_outlined),
                label: 'Estatísticas',
                backgroundColor: PrimaryColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Dashboard',
                backgroundColor: PrimaryColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.groups_outlined),
                label: 'Funcionários',
                backgroundColor: PrimaryColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.manage_accounts_outlined),
                label: 'Perfil',
                backgroundColor: PrimaryColor),
          ]),
    );
  }
}
