import 'package:flutter/material.dart';
import 'package:weather/Screens/locationScreen.dart';
import 'package:weather/services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather/services/climate.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  Location location = new Location();

  @override
  void initState(){
    super.initState();
    getLocation();
  }


  void getLocation() async{
    // int weatherID = weatherData['weather'][0]['id'];
    // String cityName = weatherData['name'];
    // String temp = (weatherData['main']['temp']).toStringAsFixed(2);
    dynamic weatherData = await WeatherModel().getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context){return LocationScreen(locationWeather: weatherData,);}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
