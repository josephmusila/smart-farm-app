import 'dart:async';
import 'dart:convert';

import 'package:characters/characters.dart';
import 'package:farm/models/solarData.dart';
import 'package:farm/screens/tableScreen.dart';
import 'package:farm/screens/tank.dart';
import 'package:farm/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:farm/cubits/data_cubit.dart';
import 'package:farm/cubits/data_state.dart';
import 'package:farm/models/model.dart';
import 'package:farm/screens/voltage.dart';
import 'package:farm/screens/dustScreen.dart';
import "package:http/http.dart" as http;

import '../models/SensorDataClass.dart';
// import 'dart/convert/'

enum SelectedScreen { temperature, voltage, dust,light }

class DataScreen extends StatefulWidget {
  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  StreamController<ListOfData> _streamController = StreamController();
  List<IoTData> datastreams = [];
  SelectedScreen selectedScreen = SelectedScreen.voltage;
  String lastUpdateTime = "";
  String lastUpdatedate = "";
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  DateTime? _selectedDay;
  DataService dataService = DataService();

  List<SensorData> voltageData = [];
  List<SensorData> dustData = [];

  @override
  void initState() {
    BlocProvider.of<DataCubit>(context).getNotificatios();
    voltageData = BlocProvider.of<DataCubit>(context).voltageData;
    dustData = BlocProvider.of<DataCubit>(context).dustData;
    super.initState();
  }

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

  Future<void> getData() async {
    final url = Uri.parse(
        "https://api.thingspeak.com/channels/2236007/feeds.json?api_key=FU3RPFWH9F3271NC&results=2");
    // final queryUrl = Uri.parse(
    //     "http://127.0.0.1:8000/api/querydata/${formatter.format(_selectedDay!)}");

    // final response = await http.get(url);

    // final dataBody = jsonDecode(response.body);
    // ListOfData iotdata = ListOfData.fromList(dataBody);

    // _streamController.sink.add(iotdata);
    setDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
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
                              selectedScreen = SelectedScreen.voltage;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 96, 47, 4)),
                          child: const Text("Voltage"),
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
                              selectedScreen = SelectedScreen.dust;
                            });
                          },
                          child: const Text("Dust Data"),
                        ),
                      ),
                      Container(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedScreen = SelectedScreen.light;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 243, 190, 0),
                          ),
                          child: const Text("Light"),
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
                height: 60,
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
              // Container(
              //     height: 500,
              //     width: double.maxFinite,
              //     child: selectedScreen == SelectedScreen.voltage
              //         ? Container(
              //             height: 650,
              //             child: ListView(
              //               children: [
              //                 VoltageScreen(data: voltageData),
              //                 // TableWidget(sensorData),
              //               ],
              //             ),
              //           )
              //         : Container(
              //             height: 650,
              //             child: ListView(
              //               children: [
              //                 // TemperatureScreen(sensorData),
              //                 // TableWidget(sensorData),
              //               ],
              //             ),
              //           )),

              Container(
                height: 500,
                width: double.maxFinite,
                // color: Colors.blue,
                child: FutureBuilder<SolarData>(
                  future: dataService.getSolarData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(
                              height: 50,
                            ),
                            Visibility(
                              visible: snapshot.hasData,
                              child: Text(
                                snapshot.data == null
                                    ? "no data"
                                    : "Loading data",
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasError) {
                        return const Text("Error");
                      } else if (snapshot.hasData) {
                        List<Feed> feeds = snapshot.data!.feeds;
                        List<SensorData> voltageData = [];
                        List<SensorData> dustData = [];
                        List<SensorData> lightData = [];

                        feeds.forEach((element) {
                          voltageData.add(SensorData(
                              dateCreated: element.createdAt,
                              name: snapshot.data!.channel.field1,
                              value: element.field1));
                        });

                        feeds.forEach((element) {
                          dustData.add(SensorData(
                              dateCreated: element.createdAt,
                              name: snapshot.data!.channel.field2,
                              value: element.field2));
                        });

                        feeds.forEach((element) {
                          lightData.add(SensorData(
                              dateCreated: element.createdAt,
                              name: snapshot.data!.channel.field3,
                              value: element.field3));
                        });

                        if (selectedScreen == SelectedScreen.voltage) {
                          return VoltageDataScreen(voltageData);
                        } else if (selectedScreen == SelectedScreen.dust) {
                          return DustDataScreen(dustData);
                        }else if(selectedScreen == SelectedScreen.light){
                          return LightDataScreen(lightData);
                        }

                        else {
                          return Container();
                        }

                        // return VoltageDataScreen(voltageData);
                      } else {
                        return const Text("Empty data");
                      }
                    } else {
                      return Text("State ${snapshot.connectionState}");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container VoltageDataScreen(List<SensorData> sensorData) {
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
              maximum: 20,
            ),
            series: <ChartSeries>[
              ColumnSeries<SensorData, String>(
                dataSource: sensorData,
                xValueMapper: (SensorData data, _) =>
                    data.dateCreated.toString().substring(10, 16),
                yValueMapper: (SensorData data, _) => double.parse(data.value),
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

Container DustDataScreen(List<SensorData> sensorData) {
  return Container(
    height: 650,
    child: ListView(
      children: [
        SfCartesianChart(
          // backgroundColor: Colors.deepOrange,
          title: ChartTitle(
            borderColor: Colors.blue,
            text: "Dust Recordings Against Time",
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
            ColumnSeries<SensorData, String>(
              dataSource: sensorData,
              xValueMapper: (SensorData data, _) =>
                  data.dateCreated.toString().substring(10,16),
              yValueMapper: (SensorData data, _) => double.parse(data.value),
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



Container LightDataScreen(List<SensorData> sensorData) {
  return Container(
    height: 650,
    child: ListView(
      children: [
        SfCartesianChart(
          // backgroundColor: Colors.deepOrange,
          title: ChartTitle(
            borderColor: Colors.blue,
            text: "SunLight Recordings Against Time",
            textStyle: const TextStyle(
              fontSize: 12,
              decoration: TextDecoration.underline,
              decorationColor: Colors.blue,
            ),
          ),
          primaryXAxis: CategoryAxis(isInversed: true),

          primaryYAxis: NumericAxis(
            minimum: 0,
            maximum: 200,
          ),
          series: <ChartSeries>[
            ColumnSeries<SensorData, String>(
              dataSource: sensorData,
              xValueMapper: (SensorData data, _) =>
                  data.dateCreated.toString().substring(10,16),
              yValueMapper: (SensorData data, _) => double.parse(data.value),
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
