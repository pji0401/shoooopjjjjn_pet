class ApiException implements Exception {
  final _message;

  final _prefix;

  ApiException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends ApiException {
  FetchDataException([String? message])
      : super(message, 'Error During Communication');
}

class BadRequestException extends ApiException {
  BadRequestException([String? message]) : super(message, 'Invalid request');
}

class NotFoundException extends ApiException {
  NotFoundException([String? message]) : super(message, "Not Found");
}

class ForbiddenException extends ApiException {
  ForbiddenException([String? message]) : super(message, "Forbidden");
}

class InternalServerError extends ApiException {
  InternalServerError([String? message])
      : super(message, "Internal Server Error");
}

class UnauthorisedException extends ApiException {
  UnauthorisedException([String? message])
      : super(message, 'Unauthorised request');
}

class InvalidInputException extends ApiException {
  InvalidInputException([String? message]) : super(message, 'Invalid Input');
}

class NoInternetException extends ApiException {
  NoInternetException([String? message])
      : super(message, 'No Internet Connection');
}