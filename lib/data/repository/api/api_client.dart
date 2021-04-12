import 'package:dio/dio.dart';
import 'package:places/data/repository/api/exceptions/network_exception.dart';

/// Dio-client for working with the API
class ApiClient {
  Dio get dio => _dio;

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://test-backend-flutter.surfstudio.ru",
      connectTimeout: 5000,
      sendTimeout: 5000,
      receiveTimeout: 5000,
      responseType: ResponseType.json,
    ),
  );

  void initInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioError error) {
          print("An error occurred: $error");
        },
        onRequest: (RequestOptions options) {
          print("Request sent");
        },
        onResponse: (Response response) {
          print("Response received");
        },
      ),
    );
  }

  /// Method for making http GET request
  Future<Object> get(String url) async {
    try {
      initInterceptors();
      final Response response = await _dio.get(url);
      if (response.statusCode == 200) return response;
    } on DioError catch (e) {
      throw NetworkException(
        requestUrl: e.request.uri.path,
        statusCode: 500,
        statusMessage: "internal server error",
      );
    }
  }

  /// Method for making a POST request for a given [url].
  /// [data] can be of type Map<String, Object> or FormData.
  Future<Response> post(
    String url, {
    Object data,
  }) async {
    try {
      Response response = await _dio.post(url, data: data);

      if (response.statusCode != 200 || response.statusCode != 201)
        throw NetworkException();

      return response;
    } on DioError catch (e) {
      throw NetworkException(
        requestUrl: e.request.uri.path,
        statusCode: 500,
        statusMessage: "internal server error",
      );
    }
  }

  void exceptionHandler(Object exception) {
    if (exception is NetworkException) {
      print(exception.toString());
      throw exception;
    } else {
      print(exception.toString());
      throw exception;
    }
  }
}
