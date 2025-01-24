import 'dart:convert';
import 'dart:io' as io;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wartel_receiver/configs/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:wartel_receiver/utils/common_functions.dart';

export 'package:http/http.dart';

typedef HttpBody = Map<String, dynamic>;
typedef HttpQuery = Map<String, dynamic>;

class HttpService {
  final storage = const FlutterSecureStorage();
  final host = AppConfig.apiHost;

  Future<Map<String, String>> getHeaders() async {
    final accessToken = await getAccessToken();

    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': "Bearer $accessToken",
    };
  }

  Uri getUri(String path, [Map<String, dynamic>?query]) {
    if (path.startsWith('/')) {
      path = path.substring(1);
    }
    return Uri.parse('$host/api/m/$path').replace(queryParameters: query);
  }

  Future<String?> getAccessToken() => storage.read(key: 'access_token');
  Future<void> setAccessToken(String accessToken) => storage.write(key: 'access_token', value: accessToken);
  Future<void> removeAccessToken() => storage.delete(key: 'access_token');

  Future<HttpResponse> request(String type, String path, { 
    HttpQuery? query, 
    HttpBody? body,
    List<http.MultipartFile>? files,
  }) async {
    try {
      final headers = await getHeaders();
      final uri = getUri(path, query);

      late http.Response response;
      if(type == 'POST') { response = await http.post(uri, headers: headers, body: json.encode(body)); }
      else if(type == 'PUT') { response = await http.put(uri, headers: headers, body: json.encode(body)); }
      else if(type == 'DELETE') { response = await http.delete(uri, headers: headers); }
      else if(type == 'POSTFORM') {
        http.MultipartRequest req = http.MultipartRequest("POST", uri);
        headers['Content-Type'] = 'multipart/form-data';
        req.headers.addAll(headers);
        
        if (files != null) {
          for (var file in files) {
            req.files.add(file);
          }
        }

        if (body != null) {
          req.fields.addAll(body as Map<String, String>);
        }

        http.StreamedResponse respStream = await req.send();
        String respBody = await respStream.stream.bytesToString();
        response = http.Response(respBody, respStream.statusCode);        
      }
      else { response = await http.get(uri, headers: headers); }

      HttpResponse resp = HttpResponse.fromJSON(response.body);
      switch (response.statusCode) {
        case 422:
          throw InvalidInputException(resp.message);
        case 400:
          throw BadRequestException(resp.message);
        case 404:
          throw NotFoundException(resp.message);
        case 405:
          throw NotFoundException(resp.message);
        case 500:
          throw InternalServerErrorException(resp.message);
        case 401:
          removeAccessToken();
          throw UnauthorizedException(resp.message);
        case 403:
          removeAccessToken();
          throw UnauthorizedException(resp.message);
        default:
      }
      return resp;
    } on io.SocketException {
      showSnackBar('Silahkan cek koneksi internet kamu.');
      rethrow;
    }
  }

  Future<HttpResponse> get(String path, [HttpQuery?query]) => request('GET', path, query: query);
  Future<HttpResponse> post(String path, [Map<String, dynamic>?body]) => request('POST', path, body: body);
  Future<HttpResponse> put(String path, [Map<String, dynamic>?body]) => request('PUT', path, body: body);
  Future<HttpResponse> delete(String path) => request('DELETE', path);
  Future<HttpResponse> postForm(String path, { List<http.MultipartFile>?files, HttpBody?body }) => request('POSTFORM', path, files: files, body: body);
}

class HttpResponse {
  final String? message;
  final dynamic data;
  final dynamic errors;
  final bool? status;

  HttpResponse({
    this.message,
    this.data,
    this.status,
    this.errors,
  });

  factory HttpResponse.fromJSON(String body) {
    Map<String, dynamic> resp = json.decode(body);
    return HttpResponse(
      message: resp['message'],
      data: resp['data'],
      errors: resp['errors'],
    );
  }
}

class CustomException implements Exception {
  final String? msg;
  final String? prefix;

  CustomException([this.msg, this.prefix]);

  @override
  String toString() {
    return "$msg";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String ?message]) : super(message, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  BadRequestException([String ?message]) : super(message, "Invalid Request: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String ?message]) : super(message, "Invalid Input: ");
}

class UnauthorizedException extends CustomException{
  UnauthorizedException([String ?message]) : super(message, "Unauthorized: ");
}

class InternalServerErrorException extends CustomException{
  InternalServerErrorException([String ?message]) : super(message, "Bad Request");
}

class NotFoundException extends CustomException{
  NotFoundException([String ?message]) : super(message, "Not Found");
}
