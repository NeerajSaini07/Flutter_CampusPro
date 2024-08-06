import 'dart:convert';

import 'dart:io';
import 'package:campuspro/Services/ApiService/Data/Network/base_api_services.dart';
import 'package:campuspro/Services/ApiService/app_exception.dart';
import 'package:campuspro/Utilities/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  @override
  Future<dynamic> getApiRequest(String url) async {
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    } catch (e) {
      throw FetchDataException('An error occurred: $e');
    }
    return responseJson;
  }

// for file data
  Future<dynamic> postFileRequest(Map<String, String> fields, String key,
      String filePath, String url) async {
    dynamic responseJson;
    try {
      final file = File(filePath);
      final fileBytes = file.readAsBytesSync();
      final fileName = file.uri.pathSegments.last;

      final multipartFile = http.MultipartFile.fromBytes(
        key,
        fileBytes,
        filename: fileName,
      );

      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields.addAll(fields);
      request.files.add(multipartFile);

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    } catch (e) {
      throw FetchDataException('An error occurred: $e');
    }
    return responseJson;
  }

  @override
  Future<dynamic> postApiRequest(var data, String url) async {
    dynamic responseJson;
    try {
      // print(data);
      // print(url);
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException();
    } on RequestTimeOut {
      throw RequestTimeOut();
    } catch (e) {
      throw FetchDataException('An error occurred: $e');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 401:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 500:
        throw SOMETHING_WENT_WRONG;
      default:
        throw FetchDataException(
            'Error accoured while communicating with server ${response.statusCode}');
    }
  }
}
