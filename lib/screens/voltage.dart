import 'dart:async';

import 'package:farm/models/SensorDataClass.dart';
import 'package:farm/screens/tableScreen.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:farm/models/model.dart';

class VoltageScreen extends StatefulWidget {
  List<SensorData> data;

  VoltageScreen({
    required this.data,
  });
  @override
  State<VoltageScreen> createState() => _VoltageScreenState();
}

class _VoltageScreenState extends State<VoltageScreen> {
  void printData() {
    print(widget.data);
  }

  @override
  void initState() {
    printData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650,
      child: ListView(
        children: [
          SfCartesianChart(
            // backgroundColor: Colors.deepOrange,
            title: ChartTitle(
              borderColor: Colors.blue,
              text: "Voltage Recordings Against Time",
              textStyle: const TextStyle(
                fontSize: 12,
                decoration: TextDecoration.underline,
                decorationColor: Colors.blue,
              ),
            ),
            primaryXAxis: CategoryAxis(isInversed: true),

            primaryYAxis: NumericAxis(
              minimum: 0,
              maximum: 600,
            ),
            series: <ChartSeries>[
              LineSeries<SensorData, String>(
                dataSource: widget.data,
                xValueMapper: (SensorData data, _) => data.dateCreated.toString().substring(0, 5),
                yValueMapper: (SensorData data, _) => double.parse(data.value),
              )
            ],
          ),
          // TablesScreen(sensorData:  widget.data, screenName: "voltage",),
        ],
      ),
    );
  }
}
