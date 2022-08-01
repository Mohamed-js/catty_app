import 'package:dio/dio.dart';

Dio dio({multipart = false}) {
  Dio dio = new Dio();
  dio.options.baseUrl = 'https://petsmating.herokuapp.com/api';
  if (multipart) {
    dio.options.headers["Content-Type"] = "multipart/form-data";
  }
  dio.options.headers['accept'] = 'Application/Json';

  return dio;
}
