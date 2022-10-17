// To parse this JSON data, do
//
//     final ioTData = ioTDataFromJson(jsonString);

import 'dart:convert';

List<IoTData> ioTDataFromJson(String str) =>
    List<IoTData>.from(json.decode(str).map((x) => IoTData.fromJson(x)));

String ioTDataToJson(List<IoTData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IoTData {
  IoTData({
    required this.photocell,
    required this.waterlevel,
    required this.soilmoisture,
    required this.temperature,
    required this.timeAdded,
    required this.dateCreated,
  });

  String photocell;
  String waterlevel;
  String soilmoisture;
  String temperature;
  String timeAdded;
  DateTime dateCreated;

  factory IoTData.fromJson(json) => IoTData(
        photocell: json["photocell"],
        waterlevel: json["waterlevel"],
        soilmoisture: json["soilmoisture"],
        temperature: json["temperature"],
        timeAdded: json["time_added"],
        dateCreated: DateTime.parse(json["date_created"]),
      );

  Map<String, dynamic> toJson() => {
        "photocell": photocell,
        "waterlevel": waterlevel,
        "soilmoisture": soilmoisture,
        "temperature": temperature,
        "time_added": timeAdded,
        "date_created":
            "${dateCreated.year.toString().padLeft(4, '0')}-${dateCreated.month.toString().padLeft(2, '0')}-${dateCreated.day.toString().padLeft(2, '0')}",
      };
}

class ListOfData {
  List<IoTData> data;
  ListOfData({
    required this.data,
  });
  factory ListOfData.fromList(List list) {
    List<IoTData> dataList = [];
    list.forEach((element) {
      dataList.add(IoTData.fromJson(element));
    });

    return ListOfData(data:dataList);
  }
}
