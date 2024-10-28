abstract class IHttpResponse {
  int get statusCode;
  dynamic get body;
  String get message;
  bool get isSuccess;
}
