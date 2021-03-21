class NetworkException implements Exception {
  final String requestUrl;
  final int statusCode;
  final String statusMessage;

  NetworkException({
    this.requestUrl,
    this.statusCode,
    this.statusMessage,
  });

  @override
  String toString() =>
      "В запросе '$requestUrl' возникла ошибка: $statusCode $statusMessage";
}
