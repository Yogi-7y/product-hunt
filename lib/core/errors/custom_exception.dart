class CustomException implements Exception {
  String? message;

  CustomException({this.message});
}

class NoDataException extends CustomException {
  NoDataException({String? message}) : super(message: message);
}
