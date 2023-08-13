// import 'package:farm/screens/tableScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:farm/models/model.dart';
//
// class TankScreen extends StatefulWidget {
//   List<IoTData> data;
//   TankScreen({
//     required this.data,
//   });
//   @override
//   State<TankScreen> createState() => _TankScreenState();
// }
//
// class _TankScreenState extends State<TankScreen> {
//   void printData() {
//     print(widget.data);
//   }
//
//   @override
//   void initState() {
//     printData();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: double.maxFinite,
//       width: double.maxFinite,
//       child: ListView(
//         children: [
//           SfCartesianChart(
//             // backgroundColor: Colors.deepOrange,
//             title: ChartTitle(
//               borderColor: Colors.blue,
//               text: "Water Level Recordings Against Time",
//               textStyle: const TextStyle(
//                 fontSize: 12,
//                 decoration: TextDecoration.underline,
//                 decorationColor: Colors.blue,
//               ),
//             ),
//             primaryYAxis: NumericAxis(
//               interval: 10,
//               minimum: 0,
//               maximum: 100,
//             ),
//             primaryXAxis: CategoryAxis(isInversed: true),
//             series: <ChartSeries>[
//               LineSeries<IoTData, String>(
//                 dataSource: widget.data,
//                 xValueMapper: (IoTData data, _) =>
//                     data.timeAdded.substring(0, 5),
//                 yValueMapper: (IoTData data, _) =>
//                     double.parse(data.voltage),
//               )
//             ],
//           ),
//           TablesScreen(
//             sensorData: widget.data,
//             screenName: "waterTank",
//           ),
//         ],
//       ),
//     );
//   }
// }
