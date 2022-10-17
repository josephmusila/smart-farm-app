import 'package:flutter/material.dart';

import 'package:farm/models/model.dart';

class TablesScreen extends StatelessWidget {
  List<IoTData> sensorData;
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
                DataCell(Text(e.timeAdded.toString().substring(0, 8))),
                DataCell(
                  screenName == "temperature"
                      ? Text("${e.temperature}C")
                      : screenName == "waterTank"
                          ? Text("${e.waterlevel}%")
                          : screenName == "soil"
                              ? Text(e.soilmoisture.toString())
                              : Text(e.photocell.toString()),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
