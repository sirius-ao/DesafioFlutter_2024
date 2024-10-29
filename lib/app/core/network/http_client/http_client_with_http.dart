import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:project_management_app/app/core/network/http_client/http_client_interface.dart';
import 'package:project_management_app/app/core/network/http_response/http_response_impl.dart';
import 'package:project_management_app/app/core/network/http_response/http_response_interface.dart';
//import 'package:http/http.dart' as http_client;

class HttpClientWithHttpPackage implements IHttpClient {
  final http.Client _httpClient;

  HttpClientWithHttpPackage() : _httpClient = http.Client();

  @override
  Future<IHttpResponse> get(String url, {Map<String, String>? headers}) async {
    
      print("GET => $url");
      final response = await _httpClient.get(Uri.parse(url), headers: headers);
      return HttpResponseImpl(
        statusCode: response.statusCode,
        body: _parseResponse(response),
        message: response.reasonPhrase ?? '',
      );
  }

  @override
  Future<IHttpResponse> post(String url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    print("POST => $url");
    final response = await _httpClient.post(
      Uri.parse(url),
      headers: headers,
      body: body,
      encoding: encoding,
    );
    return HttpResponseImpl(
      statusCode: response.statusCode,
      body: _parseResponse(response),
      message: response.reasonPhrase ?? '',
    );
  }

  @override
  Future<IHttpResponse> put(String url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    print("PUT => $url");
    final response = await _httpClient.put(
      Uri.parse(url),
      headers: headers,
      body: body,
      encoding: encoding,
    );
    return HttpResponseImpl(
      statusCode: response.statusCode,
      body: _parseResponse(response),
      message: response.reasonPhrase ?? '',
    );
  }

  @override
  Future<IHttpResponse> delete(String url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    print("DELETE => $url");
    final response = await _httpClient.delete(
      Uri.parse(url),
      headers: headers,
      body: body,
      encoding: encoding,
    );
    return HttpResponseImpl(
      statusCode: response.statusCode,
      body: _parseResponse(response),
      message: response.reasonPhrase ?? '',
    );
  }

  @override
  Future<IHttpResponse> uploadFiles(String url,
      {Map<String, String>? headers,
      Map<String, String>? fields,
      Encoding? encoding,
      required Map<File, String> files}) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));

    if (headers != null) {
      request.headers.addAll(headers);
    }

    if (fields != null) {
      request.fields.addAll(fields);
    }

  for (var entry in files.entries) {
    var file = entry.key;
    var fileName = entry.value;
    var multipartFile = http.MultipartFile(
      fileName,
      file.openRead(),
      await file.length(),
      filename: fileName,
    );
    request.files.add(multipartFile);
  }

    var streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    return HttpResponseImpl(
      statusCode: response.statusCode,
      body: _parseResponse(response),
      message: response.reasonPhrase ?? '',
    );
  }

  dynamic _parseResponse(http.Response response) {
    try{
      return json.decode(response.body);
    } catch (e) {
      return response.body;
    }
  }
}

/*import 'dart:convert';
import 'dart:io';
import 'package:batota_app/app/core/network/http_client/http_client.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
//import 'package:http/io_client.dart';
//import 'dart:io';
//final securityContext = SecurityContext.defaultContext;
//final HttpClient httpClient = HttpClient(context: securityContext)
//..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
//final IOClient httpclient = IOClient(httpClient);
import 'package:http/http.dart' as httpclient;

class HttpClientWithHttpPackage implements IHttpClient{

  @override
  Future<Response>get(String url,{ Map<String, String>? headers }) {
    var uri = Uri.parse(url);
    print("GET => $url");
    var res = httpclient.get(uri, headers: headers,);
    return res;
  }
  @override
  Future<Response>post(String url,{ Map<String, String>? headers, Object? body, Encoding? encoding }){
    var uri = Uri.parse(url);
    print("POST => $url");
    var res =  httpclient.post(uri, headers: headers, body: body, encoding: encoding);
    return res;   
  }
  @override
  Future<Response>put(String url,{ Map<String, String>? headers, Object? body, Encoding? encoding }){
    var uri = Uri.parse(url);
    print("PUT => $url");
    var res =  httpclient.put(uri, headers: headers, body: body, encoding: encoding);
    return res;   
  }
  @override
  Future<Response>delete(String url,{ Map<String, String>? headers, Object? body, Encoding? encoding }){
    var uri = Uri.parse(url);
    print("DELETE => $url");
    var res =  httpclient.delete(uri, headers: headers, body: body, encoding: encoding);
    return res; 
  }
  @override
  Future<http.StreamedResponse> uploadFiles(
    String url,{ Map<String, String>? headers, Map<String, String>? fields, Encoding? encoding, required Map<File, String> files}) async {
    final uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri);

    if (headers != null) {
      request.headers.addAll(headers);
    }

    if (fields != null) {
      request.fields.addAll(fields);
    }
    files.forEach((file, fileName) async {
      var stream = http.ByteStream(file.openRead());
      var length = await file.length();
      var multipartFile = http.MultipartFile(
        fileName,
        stream,
        length,
        filename: fileName,
      );
      request.files.add(multipartFile);
    });

    var response = await request.send();
    return response;
  }
}
*/
