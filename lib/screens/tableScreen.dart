import 'package:flutter/material.dart';

import 'package:farm/models/model.dart';

import '../models/SensorDataClass.dart';

class TablesScreen extends StatelessWidget {
  List<SensorData> sensorData;
  String screenName;
  TablesScreen({
    required this.sensorData,
    required this.screenName
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text("Date")),
        DataColumn(label: Text("Time")),
        DataColumn(label: Text("Value")),
      ],
      rows: sensorData
          .map(
            (e) => DataRow(
              cells: <DataCell>[
                DataCell(
                  Text(e.dateCreated.toString().substring(0, 10)),
                ),
                DataCell(Text(e.dateCreated.toString().substring(11, 16))),
                DataCell(
                  screenName == "voltage"
                      ? Text("${e.value}C")
                      : screenName == "dust"
                          ? Text("${e.value}%")
                          : screenName == "voltage"
                              ? Text(e.value.toString())
                              : Text(e.value.toString()),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
