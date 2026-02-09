import 'dart:math';
import 'package:dio/dio.dart';

class DioClient {
  static Dio get instance {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 5),
    ));
    
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final random = Random();
        // Simulamos latencia siempre para ver el Shimmer
        await Future.delayed(Duration(seconds: 1 + random.nextInt(3)));

        // Simulamos Error Aleatorio (20%)
        if (random.nextInt(100) < 20) {
          return handler.reject(DioException(
            requestOptions: options,
            response: Response(
              requestOptions: options,
              statusCode: random.nextBool() ? 500 : 401,
            ),
            type: DioExceptionType.badResponse,
          ));
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        final random = Random();
        // Simulamos Respuesta Vacía (15%)
        if (random.nextInt(100) < 15) {
          return handler.resolve(Response(
            requestOptions: response.requestOptions,
            data: [], 
            statusCode: 200,
          ));
        }
        return handler.next(response);
      },
    ));
    return dio;
  }
}