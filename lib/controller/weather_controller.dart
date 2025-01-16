import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/constants.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherController extends GetxController {
  bool isLoading = false;
  bool isError = false;
  String? errorMessg;

  WeatherModel? weatherModel;
  Position? userPosition;
  GetStorage storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  // fetch data based on user location
  void fetchData() async {
    try {
      isLoading = true;
      update();

      isError = false;
      errorMessg = null;
      await checkPermission();
      if (userPosition != null) {
        final response = await http.get(
          Uri.parse(
              '$url?lat=${userPosition!.latitude}&lon=${userPosition!.longitude}&appid=$apiKey'),
        );

        if (response.statusCode == 200) {
          weatherModel = WeatherModel.fromJson(response.body);
          await storeData();
        }
      } else {
        await retrieveWeatherData();
      }
    } catch (e) {
      errorMessg = 'Somting went wrong';
      if (e is SocketException) {
        errorMessg = 'Internt Connection Issue';
      } else {}
      isError = true;
    } finally {
      isLoading = false;
    }
    update();
  }

  // search location by county code or zip code
  void searchWeather(String key) async {
    try {
      isLoading = true;
      update();

      isError = false;
      errorMessg = null;

      final response = await http.get(Uri.parse('$url?q=$key&appid=$apiKey'));

      if (response.statusCode == 200) {
        weatherModel = WeatherModel.fromJson(response.body);
        await storeData();
      }
    } catch (e) {
      errorMessg = 'Somting went wrong';
      if (e is SocketException) {
        errorMessg = 'Internt Connection Issues';
      }
      isError = true;
    } finally {
      isLoading = false;
    }
    update();
  }

  // store the latest data on local sorage for better user experiance
  Future<void> storeData() async {
    await storage.write('weatherData', weatherModel!.toMap());
  }

// retrive data from local storage
  Future<void> retrieveWeatherData() async {
    Map<String, dynamic>? weatherMap =
        storage.read<Map<String, dynamic>>('weatherData');
    if (weatherMap != null) {
      weatherModel = WeatherModel.fromMap(weatherMap);
    }
    update();
  }

// ask permision for location
  Future<void> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return;
      } else {
        userPosition = await Geolocator.getCurrentPosition();
      }
    } else {
      userPosition = await Geolocator.getCurrentPosition();
    }
  }
}
