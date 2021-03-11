import 'package:dio/dio.dart';

/// Dio-client for working with the API
class Client {
  final dio = Dio(
    BaseOptions(
      // baseUrl: "https://test-backend-flutter.surfstudio.ru",
      connectTimeout: 5000,
      sendTimeout: 5000,
      receiveTimeout: 5000,
      responseType: ResponseType.json,
    ),
  );

  void _initInterceptors() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (e) {
          print("An error occurred: $e");
        },
        onRequest: (options) {
          print("Request sent");
        },
        onResponse: (e) {
          print("Response received");
        },
      ),
    );
  }

  /// Function for getting data from the API
  Future<dynamic> getData() async {
    _initInterceptors();
    final postResponse = await dio.get(
      "https://jsonplaceholder.typicode.com/users",
    );

    if (postResponse.statusCode == 200) {
      return postResponse.data;
    } else
      throw Exception(
          "Http request error. Error code ${postResponse.statusCode}");
  }
}
