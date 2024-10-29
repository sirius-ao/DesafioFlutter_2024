import 'package:project_management_app/app/core/network/http_response/http_response_interface.dart';

class HttpResponseImpl implements IHttpResponse{
  @override
  final int statusCode;
  @override
  final dynamic body;
  @override
  final String message;
  @override
  final bool isSuccess;

  HttpResponseImpl({
    required this.statusCode,
    required this.body,
    this.message = '',
    bool? isSuccess,
  }) : isSuccess = isSuccess ?? (statusCode >= 200 && statusCode < 300);

  @override
  String toString() {
    return 'HttpResponse(statusCode: $statusCode, message: $message, data: $body, isSuccess: $isSuccess)';
  }

}