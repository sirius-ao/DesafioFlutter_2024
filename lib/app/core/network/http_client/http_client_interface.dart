import 'dart:convert';
import 'dart:io';

import 'package:project_management_app/app/core/network/http_response/http_response_interface.dart';

abstract interface class IHttpClient{
  Future<IHttpResponse>get(String url,{ Map<String, String>? headers });
  Future<IHttpResponse>post(String url,{ Map<String, String>? headers, Object? body, Encoding? encoding });
  Future<IHttpResponse>put(String url,{ Map<String, String>? headers, Object? body, Encoding? encoding });
  Future<IHttpResponse>delete(String url,{ Map<String, String>? headers, Object? body, Encoding? encoding });
  Future<IHttpResponse>uploadFiles(String url,{ Map<String, String>? headers, Map<String, String>? fields, Encoding? encoding, required Map<File, String> files});
  
}