import 'package:farm/cubits/data_cubit.dart';
import 'package:farm/screens/dataScreen.dart';
import 'package:farm/screens/homepage.dart';
import 'package:farm/screens/led.dart';
import 'package:farm/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/data_logic.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Farm App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) =>DataCubit(dataService: DataService()),
        child: DataScreen(),
      ),
    );
  }
}
