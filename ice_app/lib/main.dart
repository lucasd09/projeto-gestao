import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ice_app/constants/app_constants.dart';
import 'package:ice_app/core/auth/login/ui/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ice App',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: PrimaryColor,
        scaffoldBackgroundColor: BackgroundColor,
      ),
      getPages: [
        GetPage(name: '/', page: () => Login())
      ],
    );
  }
}
