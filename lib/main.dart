import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/view/home_page.dart';

void main() async{
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WeatherController());
    return ScreenUtilInit(
      designSize: const Size(402, 874),
      minTextAdapt: false,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather APP',
        themeMode: ThemeMode.light,
        home: HomePage(),
      ),
    );
  }
}
