import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:project_management_app/app/core/network/http_client/http_client_interface.dart';
import 'package:project_management_app/app/core/network/http_response/http_response_impl.dart';
import 'package:project_management_app/app/core/network/http_response/http_response_interface.dart';

class HttpClientWithDioPackage implements IHttpClient {
  final Dio _dio;

  HttpClientWithDioPackage() : _dio = Dio();

  @override
  Future<IHttpResponse> get(String url, {Map<String, String>? headers}) async {
    print("GET => $url");
    final response = await _dio.get(
      url,
      options: Options(
        validateStatus: (status) {
          // Retorna true para todos os códigos de status (mesmo os erros)
          return status != null;
        },
        headers: headers),
    );
    return HttpResponseImpl(
      statusCode: response.statusCode ?? 500,
      body: response.data,
      message: response.statusMessage ?? '',
    );
  }

  @override
  Future<IHttpResponse> post(String url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    print("POST => $url");
    final response = await _dio.post(
      url,
      data: body,
      options: Options(
        validateStatus: (status) {
          // Retorna true para todos os códigos de status (mesmo os erros)
          return status != null;
        },
        headers: headers),
    );
    print("TYPE STATUS CODE => ${response.statusCode.runtimeType}");
    return HttpResponseImpl(
      statusCode: response.statusCode ?? 500,
      body: response.data,
      message: response.statusMessage ?? '',
    );
  }

  @override
  Future<IHttpResponse> put(String url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    print("PUT => $url");
    final response = await _dio.put(
      url,
      data: body,
      options: Options(
        validateStatus: (status) {
          // Retorna true para todos os códigos de status (mesmo os erros)
          return status != null;
        },
        headers: headers),
    );
    return HttpResponseImpl(
      statusCode: response.statusCode ?? 500,
      body: response.data,
      message: response.statusMessage ?? '',
    );
  }

  @override
  Future<IHttpResponse> delete(String url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    print("DELETE => $url");
    final response = await _dio.delete(
      url,
      data: body,
      options: Options(
        validateStatus: (status) {
          // Retorna true para todos os códigos de status (mesmo os erros)
          return status != null;
        },
        headers: headers),
    );
    return HttpResponseImpl(
      statusCode: response.statusCode ?? 500,
      body: response.data,
      message: response.statusMessage ?? '',
    );
  }

  @override
  Future<IHttpResponse> uploadFiles(String url,
      {Map<String, String>? headers,
      Map<String, String>? fields,
      Encoding? encoding,
      required Map<File, String> files}) async {
    FormData formData = FormData();

    fields?.forEach((key, value) {
      formData.fields.add(MapEntry(key, value));
    });

    files.forEach((file, fileName) async {
      formData.files.add(MapEntry(
        fileName,
        await MultipartFile.fromFile(file.path, filename: fileName),
      ));
    });

    final response = await _dio.post(
      url,
      data: formData,
      options: Options(
        validateStatus: (status) {
          // Retorna true para todos os códigos de status (mesmo os erros)
          return status != null;
        },
        headers: headers),
    );
    return HttpResponseImpl(
      statusCode: response.statusCode ?? 500,
      body: response.data,
      message: response.statusMessage ?? '',
    );
  }
}
