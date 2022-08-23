import 'package:farm/models/model.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

class DataService {
  Future<List<IoTData>> getData() async {
    final url = Uri.parse("http://192.168.1.101:8000/api/listdata");

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
}
