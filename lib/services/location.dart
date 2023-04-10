import 'package:geolocator/geolocator.dart';

class Location{
  double? lat;
  double? long;

  Future<void> getLocation()async{
    if(await Geolocator.checkPermission() == LocationPermission.denied){
      Geolocator.requestPermission().then((value) => print(value));
    }
    Position pos;
    try {
      pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      this.lat = pos.latitude;
      this.long = pos.longitude;
    }
    catch(e){
      print(e);
    }

  }

}