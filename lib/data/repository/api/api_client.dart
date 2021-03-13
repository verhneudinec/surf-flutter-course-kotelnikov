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
        onError: (e) {
          print("An error occurred: $e");
        },
        onRequest: (options) {
          print("Request sent");
        },
        onResponse: (Response response) {
          print("Response received");
        },
      ),
    );
  }

  // Response handler
  dynamic responseHandler(Response postResponse) {
    print(postResponse.data.elementAt(0)["id"]);
    if (postResponse.statusCode == 200) {
      return postResponse.data;
    } else {
      throw Exception(
          "Http request error. Error code ${postResponse.statusCode}");
    }
  }
}
