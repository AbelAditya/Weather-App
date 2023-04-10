import 'dart:convert';

import 'package:http/http.dart';

class Network{
  Network(this.url);
  final String url;

  static Future getWeather(String url)async{
    Response resp = await get(Uri.parse(url));

    if(resp.statusCode == 200){
      return jsonDecode(resp.body);
    }
    else{
      print("API call return failed");
    }
  }
}
