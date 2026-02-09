import 'package:dio/dio.dart';

class DioClient {
  static Dio get instance {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
    ));
    
    // Eliminamos el Random y el Future.delayed
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Pasa directamente a la petición sin esperar y sin fallar
        return handler.next(options);
      },
    ));
    
    return dio;
  }
}