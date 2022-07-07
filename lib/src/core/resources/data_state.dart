import 'package:dio/dio.dart';

class DataState<T> {
  final T data;
  final DioError error;

  const DataState({required this.data, required this.error});
}

// class DataSuccess<T> {
//   const DataSuccess(T data);
// }

// class DataFailed<T> {
//   const DataFailed(DioError error);
// }
