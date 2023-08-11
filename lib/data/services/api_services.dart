// import 'dart:convert';

import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class ApiServices {
//  Future  getweather() async {
//     String location = 'Hasilpur';
//     String apiId = 'bec840c56f9379e270e9b2eec6724a30';
//     String apiUrl =
//         'https://api.openweathermap.org/data/2.5/forecast?q=$location,&APPID=$apiId';
//     try {
//       var response = await http.get(Uri.parse(apiUrl));
//       if (response.statusCode == 200) {
//         Map data = jsonDecode(response.body);

//         return data;
//       } else {
//         throw 'Unexpected Error occur';
//       }
//     } catch (e) {
//       throw e.toString();
//     }
//   }

  Future<Map> getWeatherByCoordinates(Position position) async {
    try {
      double latitude = position.latitude;
      double longitude = position.longitude;
      print(position.latitude);

      print(position.longitude);

      String apiId = 'bec840c56f9379e270e9b2eec6724a30';
      String apiUrl =
          'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&APPID=$apiId';

      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        return data;
      } else {
        throw 'Unexpected Error occur';
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
