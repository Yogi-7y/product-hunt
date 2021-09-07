import 'package:flutter/cupertino.dart';

@immutable
class ApiResponse<T> {
  final T? data;
  final CustomResponseStatus? status;
  final String? message;

  const ApiResponse._({
    this.data,
    this.status,
    this.message,
  });

  factory ApiResponse.loading() =>
      ApiResponse<T>._(status: CustomResponseStatus.loading);

  factory ApiResponse.success({String? message, T? data}) => ApiResponse<T>._(
      message: message, status: CustomResponseStatus.success, data: data);

  factory ApiResponse.error(String message) =>
      ApiResponse._(message: message, status: CustomResponseStatus.error);

  factory ApiResponse.fromError(Map<String, dynamic> error) => ApiResponse._(
        message: error['message'] as String,
        status: CustomResponseStatus.error,
      );

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ApiResponse<T> &&
        o.data == data &&
        o.status == status &&
        o.message == message;
  }

  @override
  int get hashCode => data.hashCode ^ status.hashCode ^ message.hashCode;
}

enum CustomResponseStatus { loading, success, error }
