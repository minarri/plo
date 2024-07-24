class ReturnType<T> {
  final String? message;
  final T? data;

  ReturnType({this.message, this.data});

  @override
  String toString() {
    return 'ReturnType{errorMessage: $message, data: $data}';
  }
}

class ErrorReturnType<T> extends ReturnType<T> {
  @override
  final T? data;
  final dynamic error;
  final String? debugMessage;
  ErrorReturnType({String message = "Something went wrong. Please try again later.", this.data, this.error, this.debugMessage})
      : super(message: message, data: data);

  @override
  String toString() {
    return 'ErrorReturnType{errorMessage: $message, data(usually error object): $data}';
  }
}

class SuccessReturnType<T> extends ReturnType<T> {
  final bool isSuccess;
  @override
  final String? message;
  @override
  final T? data;
  SuccessReturnType({this.message = "Success", this.data, required this.isSuccess}) : super(message: message, data: data);

  @override
  String toString() {
    return 'SuccessReturnType{errorMessage: $message, isSuccess: $isSuccess, data: $data}';
  }
}

class ErrorException implements Exception {
  final String message;
  final dynamic data;
  ErrorException({this.message = "Unknown error occured", this.data});

  @override
  String toString() {
    return 'ErrorException{message: $message, data: $data}';
  }
}