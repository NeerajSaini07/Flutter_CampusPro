// ignore_for_file: prefer_typing_uninitialized_variables, annotate_overrides

import 'package:campuspro/Controllers/exception_controller.dart';
import 'package:get/get.dart';

class AppExceptions implements Exception {
  final _message;
  final _prefix;
  AppExceptions([this._message, this._prefix]);

  String toString() {
    final ExceptionController exceptionController =
        Get.find<ExceptionController>();
    exceptionController.showDialog(title: _prefix, message: _message);
    return '$_message';
  }
}

class InternetException extends AppExceptions {
  InternetException([String? message])
      : super(
            "Please check your internet connection.", "No Internet Connection");
}

class RequestTimeOut extends AppExceptions {
  RequestTimeOut([String? message])
      : super("The server took too long to respond. Please try again later.",
            "Request Timed Out");
}

class ServerException extends AppExceptions {
  ServerException([String? message])
      : super("An error occurred on the server. Please try again later.",
            "Internal Server Error");
}

class InvalidUrlException extends AppExceptions {
  InvalidUrlException([String? message])
      : super(
            "The URL provided is invalid. Please check the URL and try again.",
            "Invalid URL");
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message])
      : super("An error occurred while fetching data. Please try again.",
            "Fetch Data Error");
}

class UnauthorizedException extends AppExceptions {
  UnauthorizedException([String? message])
      : super("You are not authorized to access this resource. Please log in.",
            "Unauthorized");
}
