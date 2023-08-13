import 'package:farm/models/model.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

import '../models/solarData.dart';

class DataService {
  Future<List<IoTData>> getData() async {
    final url = Uri.parse("http://192.168.43.134:8000/api/listdata");

    var response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        List<dynamic> list = json.decode(response.body);
        return list.map((e) => IoTData.fromJson(e)).toList();
      } else {
        return <IoTData>[];
      }
    } on Exception catch (e) {
      print(e);
      return <IoTData>[];
    }
  }
  
  
  Future<SolarData> getSolarData() async{
    final url = Uri.parse("https://api.thingspeak.com/channels/2236007/feeds.json?api_key=FU3RPFWH9F3271NC&results=10");
    var response = await http.get(url);

      // print(response.body);
        return solarDataFromJson(response.body);

  }
}
