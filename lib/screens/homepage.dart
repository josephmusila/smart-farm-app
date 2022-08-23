import 'package:farm/cubits/data_cubit.dart';
import 'package:farm/cubits/data_logic.dart';
import 'package:farm/screens/led.dart';
import 'package:farm/services/services.dart';
import 'package:farm/widgets/waterTank.dart';
import 'package:farm/widgets/welcomeWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import "package:http/http.dart" as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<SalesDetails> details = [];

  // void loadSalesData() {
  //   details = [
  //     SalesDetails("Jan", 200),
  //     SalesDetails("Feb", 150),
  //     SalesDetails("Mar", 120),
  //     SalesDetails("Apr", 160),
  //     SalesDetails("May", 100)
  //   ];
  // }

  // void loadSalesData() {
  //   for (int i = 0; i < subjects.length; i++) {
  //     details.add(SalesDetails(subjects[i], marks[i]));
  //   }
  // }

  List<String> subjects = [
    "maths",
    "english",
    "kiswahili",
    "science",
    "social"
  ];
  List<int> marks = [70, 75, 60, 80, 90];

  Future<String> getData() async {
    final url = Uri.parse("http://192.168.1.101:8000/api/listdata");

    http.Response response = await http.get(url);

    return response.body;
  }

  @override
  void initState() {
    // loadSalesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          child: ListView(
            children: [
              Container(
                height: size * 0.2,
                color: Colors.blue,
                child: Welcome(),
              ),
              const Divider(),
              Container(
                height: 150,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Home(),
                    ),
                  ],
                ),
              ),
              
              Container(
                height: size * 0.6,
                child: BlocProvider(
                  create: (context) => DataCubit(dataService: DataService()),
                  child: DataLogicScreen(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
