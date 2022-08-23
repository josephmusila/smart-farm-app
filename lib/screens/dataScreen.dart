import 'dart:async';
import 'dart:convert';

import 'package:characters/characters.dart';
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
  DateTime lastUpdatedate = DateTime.now();

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void initState() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      getData();
      lastUpdate();
    });
    super.initState();
  }

  Future<void> getData() async {
    final url = Uri.parse("http://127.0.0.1:8000/api/listdata");
    final response = await http.get(url);

    final dataBody = jsonDecode(response.body);
    ListOfData iotdata = ListOfData.fromList(dataBody);

    _streamController.sink.add(iotdata);
  }

  //  var timeFormat = DateFormat("HH:mm")

  void lastUpdate() {
    IoTData iotdata = datastreams.last;
    lastUpdateTime = iotdata.timeAdded;
    lastUpdatedate = iotdata.dateCreated;

    setState(() {});
    print(lastUpdateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      margin: const EdgeInsets.all(5),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedScreen = SelectedScreen.soil;
                  });
                },
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 96, 47, 4)),
                child: const Text("Soil"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedScreen = SelectedScreen.temperature;
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 224, 74, 10),
                ),
                child: const Text("Temperature"),
              ),
              ElevatedButton(
                onPressed: () {
                  // BlocProvider.of<DataCubit>(context).getNotificatios();
                  //  setState(() {

                  //  });
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return SoilScreen(data: datastreams);
                  }));
                },
                child: const Text("Water Tank"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedScreen = SelectedScreen.lighting;
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 243, 190, 0),
                ),
                child: const Text("Lighting"),
              ),
            ],
          ),
          const Divider(
            color: Colors.blue,
          ),
          Container(
            height: 50,
            width: double.maxFinite,
            child: Center(
              child: Text(
                "Last Date Updated: $lastUpdatedate",
              ),
            ),
          ),
          Container(
            height: 50,
            child: const Center(
              child: Text(
                "Heating System",
                style: TextStyle(
                  color: Colors.deepOrange,
                ),
              ),
            ),
          ),
          StreamBuilder<ListOfData>(
            stream: _streamController.stream,
            builder: (context, snapdata) {
              switch (snapdata.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                default:
                  if (snapdata.hasError) {
                    return Text("please wait ....");
                  } else {
                    List<IoTData> sensorData = snapdata.data!.data;
                    datastreams = sensorData;
                    print(sensorData);
                    if (selectedScreen == SelectedScreen.soil) {
                      return SoilScreen(
                        data: sensorData,
                      );
                    }
                    if (selectedScreen == SelectedScreen.temperature) {
                      return TemperatureScreen(sensorData);
                    }
                    if (selectedScreen == SelectedScreen.lighting) {
                      return LightScreen(data: sensorData);
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
        ],
      ),
    );
  }

  Container TemperatureScreen(List<IoTData> sensorData) {
    return Container(
      child: SfCartesianChart(
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
          maximum: 40,
        ),
        series: <ChartSeries>[
          ColumnSeries<IoTData, String>(
            dataSource: sensorData,
            xValueMapper: (IoTData data, _) => data.timeAdded.substring(0, 5),
            yValueMapper: (IoTData data, _) => double.parse(data.temperature),
          )
        ],
      ),
    );
  }
}
