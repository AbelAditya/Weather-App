import 'package:flutter/material.dart';
import 'package:weather/Screens/cityScreen.dart';
import 'package:weather/utilities/constants.dart';
import 'package:weather/services/climate.dart';


class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  dynamic data;
  int temp=0;
  String cityName='';
  int id=0;
  String weatherMessage = '';
  String weatherIcon = '';

  @override
  void initState(){
    super.initState();
    data = widget.locationWeather;

    dataProcess(data);
  }

  void dataProcess(dynamic data){
    if (data==null){
      setState(() {
        temp =0;
        weatherIcon = "Error";
        weatherMessage = "Could not fetch data";
      });
      return;
    }
    setState(() {
      temp = data['main']['temp'].toInt();
      cityName = data['name'];
      id = data['weather'][0]['id'];

      weatherMessage = "${WeatherModel().getMessage(temp)} in $cityName";
      weatherIcon = '${WeatherModel().getWeatherIcon(id)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async{
                      dynamic x = await WeatherModel().getLocationWeather();
                      dataProcess(x);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: ()async {
                      var name = await Navigator.push(context, MaterialPageRoute(builder: (context){return CityScreen();}));
                      if (name!=null){
                        dynamic data = await WeatherModel().getCityWeather(name);
                        dataProcess(data);
                        print(name);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${this.temp}°C ',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  weatherMessage,
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
