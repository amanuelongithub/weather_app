import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainCondition extends StatelessWidget {
  final String? temp;
  final String? location;
  final String? minTemp;
  final String? maxTemp;
  final String? feelsTemp;
  final String? condition;
  const MainCondition(
      {super.key,
      this.temp,
      this.location,
      this.minTemp,
      this.maxTemp,
      this.feelsTemp,
      this.condition});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (temp != null) ...{
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Text(
                    temp!,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 80.sp,
                        fontWeight: FontWeight.bold),
                  ),
                  Positioned(
                      top: 5,
                      right: -15,
                      child: Text(
                        'o',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.sp,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              buildIcon()
            ],
          )
        },
        if (condition != null) ...{
          Text(
            condition!,
            style: TextStyle(
                color: Colors.white,
                fontSize: 23.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30.h)
        },
        if (location != null) ...{
          Row(
            children: [
              Text(
                location!,
                style: TextStyle(
                    color: Colors.grey[100],
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.location_on,
                size: 18,
                color: Colors.grey[300],
              )
            ],
          )
        },
        SizedBox(height: 5.h),
        Row(
          children: [
            buildDegree(maxTemp!),
            Text(
              '  / ',
              style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400),
            ),
            buildDegree(minTemp!),
            Text(
              '    Feels Like ',
              style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400),
            ),
            buildDegree(feelsTemp!),
          ],
        )
      ],
    );
  }

  buildDegree(String value) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.grey[300],
            fontSize: 16.sp,
          ),
        ),
        Positioned(
            top: -2,
            right: -5,
            child: Text(
              'o',
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 9.sp,
              ),
            )),
      ],
    );
  }

  Widget buildIcon() {
    switch (condition) {
      case 'Clouds':
        return Icon(Icons.cloud, color: Colors.grey[300], size: 65.sp);
      case 'Rain':
        return Icon(Icons.umbrella, color: Colors.grey[300], size: 65.sp);
      case 'Snow':
        return Icon(Icons.cloudy_snowing, color: Colors.grey[300], size: 65.sp);
      case 'Thunderstorm':
        return Icon(Icons.thunderstorm, color: Colors.grey[300], size: 65.sp);
      case 'Fog':
        return Icon(Icons.foggy, color: Colors.grey[300], size: 65.sp);
      default:
        return Icon(Icons.sunny, color: Colors.amber, size: 65.sp);
    }
  }
}
