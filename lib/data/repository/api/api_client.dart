import 'package:dio/dio.dart';

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

  // Response handler
  Object responseHandler(Response postResponse) {
    if (postResponse.statusCode == 200) {
      return postResponse.data;
    } else {
      throw Exception(
          "Http request error. Error code ${postResponse.statusCode}");
    }
  }
}
