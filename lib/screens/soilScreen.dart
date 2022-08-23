import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:farm/models/model.dart';

class SoilScreen extends StatefulWidget {
  List<IoTData> data;
  SoilScreen({
    required this.data,
  });
  @override
  State<SoilScreen> createState() => _SoilScreenState();
}

class _SoilScreenState extends State<SoilScreen> {
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
    return   Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: ListView(
          children: [
            SfCartesianChart(
              // backgroundColor: Colors.deepOrange,
              title: ChartTitle(
                borderColor: Colors.blue,
                text: "Soil mositure Recordings Against Time",
                textStyle: const TextStyle(
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.blue,
                ),
              ),
              primaryYAxis: NumericAxis(
                interval: 50,
                minimum: 100 ,
                maximum: 1100,
              ),
              primaryXAxis: CategoryAxis(isInversed: true),
              series: <ChartSeries>[
                LineSeries<IoTData, String>(
                  dataSource: widget.data,
                  xValueMapper: (IoTData data, _) =>
                      data.timeAdded.substring(0, 5),
                  yValueMapper: (IoTData data, _) => data.soilmoisture,
                )
              ],
            ),
          ],
        ),
      );
    
  }
}
