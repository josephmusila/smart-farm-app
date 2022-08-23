import 'package:farm/cubits/data_state.dart';
import 'package:farm/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit({
    required this.dataService,
   
  }) : super(DataInitialState()) {
    emit(DataLoadingState());
  }

  final DataService dataService;

  late final data;

  void getNotificatios() async {
    try {
      emit(DataLoadingState());
      data = await dataService.getData();
      print(data);
      if (data == null) {
        emit(NoDataState());
      }
      emit(DataLoadedState(data:data));
    } catch (e) {}
  }
}
