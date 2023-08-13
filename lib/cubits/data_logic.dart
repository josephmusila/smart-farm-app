import 'dart:async';

import 'package:farm/cubits/data_cubit.dart';
import 'package:farm/cubits/data_state.dart';
import 'package:farm/models/model.dart';
import 'package:farm/screens/dataScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataLogicScreen extends StatefulWidget {
  DataLogicScreen({Key? key}) : super(key: key);

  @override
  State<DataLogicScreen> createState() => _DataLogicScreenState();
}

class _DataLogicScreenState extends State<DataLogicScreen> {
  Timer? timer;
  @override
  void initState() {
    // timer = Timer.periodic(const Duration(seconds: 60),
    //     (Timer t) => BlocProvider.of<DataCubit>(context).getNotificatios());
    // setState(() {});

    BlocProvider.of<DataCubit>(context).getNotificatios();

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  List<IoTData> myData = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          child: BlocBuilder<DataCubit, DataState>(builder: (context, state) {
            if (state is DataLoadingState) {
              // return const Center(child: CircularProgressIndicator());
              return DataScreen();
              //  setState(() {});

            }
            else if (state is DataLoadedState) {
              //  setState(() {});

              // myData = state.data;
              return DataScreen();
            } else {
              return Container();
            }
          }),
        ),
      ),
    );
  }
}
