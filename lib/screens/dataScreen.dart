import 'dart:async';
import 'dart:convert';

import 'package:characters/characters.dart';
import 'package:farm/screens/tableScreen.dart';
import 'package:farm/screens/tank.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:farm/cubits/data_cubit.dart';
import 'package:farm/cubits/data_state.dart';
import 'package:farm/models/model.dart';
import 'package:farm/screens/lightIntensity.dart';
import 'package:farm/screens/soilScreen.dart';
import "package:http/http.dart" as http;
// import 'dart/convert/'

enum SelectedScreen { temperature, soil, waterTank, lighting }

class DataScreen extends StatefulWidget {
  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  StreamController<ListOfData> _streamController = StreamController();
  List<IoTData> datastreams = [];
  SelectedScreen selectedScreen = SelectedScreen.temperature;
  String lastUpdateTime = "";
  String lastUpdatedate = "";
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  DateTime? _selectedDay;

  void setDate() {
    IoTData lastItem = datastreams.first;
    lastUpdatedate = lastItem.dateCreated.toString().substring(0, 10);
    lastUpdateTime = lastItem.timeAdded.substring(0, 8);

    print(lastUpdateTime);

    setState(() {});
  }

  @override
  void dispose() {
    _streamController.close();
  }

  void showDatePickerModel() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2018),
            lastDate: DateTime(2024))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDay = pickedDate;
      });
    });
  }

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      getData();
      // lastUpdate();
    });
    super.initState();
  }

  Future<void> getData() async {
    final url = Uri.parse("http://192.168.43.87:8000/api/listdata");
    // final queryUrl = Uri.parse(
    //     "http://127.0.0.1:8000/api/querydata/${formatter.format(_selectedDay!)}");

    final response = await http.get(url);

    final dataBody = jsonDecode(response.body);
    ListOfData iotdata = ListOfData.fromList(dataBody);

    _streamController.sink.add(iotdata);
    setDate();
  }

  //  var timeFormat = DateFormat("HH:mm")

  // void lastUpdate() {
  //   IoTData iotdata = datastreams.last;
  //   lastUpdateTime = iotdata.timeAdded;
  //   lastUpdatedate = iotdata.dateCreated;

  //   setState(() {});
  //   print(lastUpdateTime);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      margin: const EdgeInsets.all(5),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedScreen = SelectedScreen.soil;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 96, 47, 4)),
                      child: const Text("Soil Moisture"),
                    ),
                  ),
                  Container(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedScreen = SelectedScreen.temperature;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 224, 74, 10),
                      ),
                      child: const Text("Temperature"),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.blue,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedScreen = SelectedScreen.waterTank;
                        });
                      },
                      child: const Text("Water Tank"),
                    ),
                  ),
                  Container(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedScreen = SelectedScreen.lighting;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 243, 190, 0),
                      ),
                      child: const Text("Lighting"),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            color: Colors.blue,
          ),
          Container(
            height: 50,
            width: double.maxFinite,
            child: Card(
              elevation: 5,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      lastUpdateTime == null
                          ? "Loading"
                          : "Last Date Updated: $lastUpdatedate",
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      lastUpdateTime == null
                          ? "Loading"
                          : "Last Time Updated: $lastUpdateTime",
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: StreamBuilder<ListOfData>(
              stream: _streamController.stream,
              builder: (context, snapdata) {
                switch (snapdata.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    if (snapdata.hasError) {
                      return const Text("please wait ....");
                    } else {
                      List<IoTData> sensorData = snapdata.data!.data;
                      datastreams = sensorData;
                      print(sensorData);
                      if (selectedScreen == SelectedScreen.soil) {
                        return Container(
                          height: 650,
                          child: ListView(
                            children: [
                              SoilScreen(data: sensorData),
                              // TableWidget(sensorData),
                            ],
                          ),
                        );
                      }
                      if (selectedScreen == SelectedScreen.temperature) {
                        return Container(
                          height: 650,
                          child: ListView(
                            children: [
                              TemperatureScreen(sensorData),
                              // TableWidget(sensorData),
                            ],
                          ),
                        );
                      }
                      if (selectedScreen == SelectedScreen.lighting) {
                        return LightScreen(data: sensorData);
                        //  return Container(
                        //   height: 650,
                        //   child: ListView(
                        //     children: [
                        //        LightScreen(data: sensorData),
                        //       // TableWidget(sensorData),
                        //     // ],
                        //   ),
                        // );

                      }
                      if (selectedScreen == SelectedScreen.waterTank) {
                        return Container(
                          height: 650,
                          child: ListView(
                            children: [
                              TankScreen(data: sensorData),
                              // TableWidget(sensorData),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          child: const Center(
                            child: Text(
                              " Please Select Data You  need",
                            ),
                          ),
                        );
                      }
                    }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Container TemperatureScreen(List<IoTData> sensorData) {
    return Container(
      height: 650,
      child: ListView(
        children: [
          SfCartesianChart(
            // backgroundColor: Colors.deepOrange,
            title: ChartTitle(
              borderColor: Colors.blue,
              text: "Temperature Recordings Against Time",
              textStyle: const TextStyle(
                fontSize: 12,
                decoration: TextDecoration.underline,
                decorationColor: Colors.blue,
              ),
            ),
            primaryXAxis: CategoryAxis(isInversed: true),

            primaryYAxis: NumericAxis(
              minimum: 10,
              maximum: 80,
            ),
            series: <ChartSeries>[
              ColumnSeries<IoTData, String>(
                dataSource: sensorData,
                xValueMapper: (IoTData data, _) =>
                    data.timeAdded.substring(0, 5),
                yValueMapper: (IoTData data, _) =>
                    double.parse(data.temperature),
              )
            ],
          ),
          TablesScreen(
            sensorData: sensorData,
            screenName: "temperature",
          ),
        ],
      ),
    );
  }
}
