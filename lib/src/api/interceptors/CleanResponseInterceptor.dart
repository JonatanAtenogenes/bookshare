import 'package:dio/dio.dart';

class CleanResponseInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Verifica si la respuesta tiene la estructura esperada
    if (response.data is Map<String, dynamic> &&
        response.data.containsKey('original')) {
      // Reemplaza la respuesta completa con el contenido de `original`
      response.data = response.data['original'];
    }
  }
}
