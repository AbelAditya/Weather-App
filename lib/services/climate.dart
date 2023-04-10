import 'package:weather/services/location.dart';
import 'package:weather/services/network.dart';

class WeatherModel {
  Future getCityWeather(String name)async{
    dynamic weatherData = await Network.getWeather("https://api.openweathermap.org/data/2.5/weather?q=${name}&appid=230c3f1c41224e8ad1072b1131567cbc&units=metric");

    return weatherData;
  }

  Future getLocationWeather()async{
    Location location = Location();
    await location.getLocation();
    print(location.lat);
    print(location.long);

    dynamic weatherData = await Network.getWeather("https://api.openweathermap.org/data/2.5/weather?lat=${location.lat}&lon=${location.long}&appid=230c3f1c41224e8ad1072b1131567cbc&units=metric");

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
