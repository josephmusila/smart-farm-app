import 'package:farm/cubits/data_state.dart';
import 'package:farm/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/SensorDataClass.dart';
import '../models/solarData.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit({
    required this.dataService,
  }) : super(DataInitialState()) {
    emit(DataLoadingState());
  }

  final DataService dataService;

  late final data;

  List<SensorData> voltageData = [];
  List<SensorData> dustData = [];
  late SolarData solarData;

  void getNotificatios() async {

      emit(DataLoadingState());
      solarData = await dataService.getSolarData();
      print(solarData.channel.name);
      // setData();

      emit(DataLoadedState(data: solarData));

      if(solarData !=null){
        setData();
      }else{
        print("No Adat");
      }

  }

  void setData() {
    if (solarData != null) {
      List<Feed> feeds = solarData.feeds;

      feeds.forEach((element) {
        voltageData.add(SensorData(
            dateCreated: element.createdAt,
            name: solarData.channel.field1,
            value: element.field1));

        dustData.add(SensorData(
            dateCreated: element.createdAt,
            name: solarData.channel.field2,
            value: element.field2));
      });
    }
  }
}
