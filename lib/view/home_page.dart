import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/weather_controller.dart';
import 'package:weather_app/view/widgets/main_condition.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blueGrey,
            Colors.grey,
          ],
        ),
      ),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: GetBuilder<WeatherController>(builder: (weatherController) {
          if (weatherController.isLoading) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          } else if (weatherController.isError == true) {
            return Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                    child: Text(
                  weatherController.errorMessg!,
                  style: TextStyle(color: Colors.white),
                )));
          } else if (weatherController.weatherModel == null) {
            return Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                    child: Text(
                  'Enable your location please',
                  style: TextStyle(color: Colors.white),
                )));
          }
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: Size(double.infinity, 135.h),
              child: Column(
                children: [
                  AppBar(
                    toolbarHeight: 80,
                    backgroundColor: Colors.transparent,
                    leading: Container(),
                    leadingWidth: 20.w,
                    title: Text(
                      'Weather app',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextField(
                      controller: searchText,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide.none),
                        hintText: 'Search ',
                        hintStyle:
                            TextStyle(fontSize: 16.sp, color: Colors.white),
                        focusColor: Colors.transparent,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: const Color.fromARGB(85, 209, 209, 209),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 30.w),
                        // suffix: ,
                        suffixIcon: IconButton(
                          onPressed: () {
                            weatherController
                                .searchWeather(searchText.text);
                          },
                          icon: Icon(Icons.search),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(children: [
                SizedBox(height: 20),
                MainCondition(
                  temp: convertToceCelsius(
                          weatherController.weatherModel!.temp!)
                      .toString(),
                  condition: weatherController.weatherModel!.condition!,
                  location: weatherController.weatherModel!.name!,
                  minTemp: convertToceCelsius(
                          weatherController.weatherModel!.minTemp!)
                      .toString(),
                  maxTemp: convertToceCelsius(
                          weatherController.weatherModel!.maxTemp!)
                      .toString(),
                  feelsTemp: convertToceCelsius(
                          weatherController.weatherModel!.feelsTemp!)
                      .toString(),
                )
              ]),
            ),
          );
        }),
      ),
    );
  }

  int convertToceCelsius(double kelvin) {
    return (kelvin - 273.15).toInt();
  }
}
