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
    required this.voltage,
    required this.dust,

    required this.temperature,
    required this.timeAdded,
    required this.dateCreated,
  });

  String voltage;
  String dust;

  String temperature;
  String timeAdded;
  DateTime dateCreated;

  factory IoTData.fromJson(json) => IoTData(
    voltage: json["voltage"],
    dust: json["dust"],

        temperature: json["temperature"],
        timeAdded: json["time_added"],
        dateCreated: DateTime.parse(json["date_created"]),
      );

  Map<String, dynamic> toJson() => {
        "voltage": voltage,
        "dust": dust,

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
