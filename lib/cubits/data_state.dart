import 'package:equatable/equatable.dart';
import 'package:farm/models/model.dart';



abstract class DataState extends Equatable {}

class DataInitialState extends DataState {
  @override
  List<Object> get props => [];
}

class DataLoadingState extends DataState {
  @override
  List<Object> get props => [];
}

class NoDataState extends DataState {
  @override
  List<Object> get props => [];
}

class DataLoadedState extends DataState {
  final List<IoTData> data;
  DataLoadedState({
    required this.data,
  });
  @override
  List<Object> get props => [data];
}

class DataErrorState extends DataState {
  @override
  List<Object> get props => [];
}