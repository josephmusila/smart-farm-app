import 'dart:async';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:farm/models/model.dart';

class LightScreen extends StatefulWidget {
  List<IoTData> data;

  LightScreen({
    required this.data,
  });
  @override
  State<LightScreen> createState() => _LightScreenState();
}

class _LightScreenState extends State<LightScreen> {
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
      
      child: SfCartesianChart(
        // backgroundColor: Colors.deepOrange,
        title: ChartTitle(
          borderColor: Colors.blue,
          text: "Light Intensity Recordings Against Time",
          textStyle: const TextStyle(
            fontSize: 12,
            decoration: TextDecoration.underline,
            decorationColor: Colors.blue,
          ),
        ),
        primaryXAxis: CategoryAxis(isInversed: true),

        primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: 400,
        ),
        series: <ChartSeries>[
          LineSeries<IoTData, String>(
            dataSource: widget.data,
            xValueMapper: (IoTData data, _) => data.timeAdded.substring(0, 5),
            yValueMapper: (IoTData data, _) => data.photocell,
          )
        ],
      ),
    );
  }
}
