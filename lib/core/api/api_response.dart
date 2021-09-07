import 'package:flutter/cupertino.dart';

@immutable
class CustomResponse<T> {
  final T? data;
  final CustomResponseStatus? status;
  final String? message;

  const CustomResponse._({
    this.data,
    this.status,
    this.message,
  });

  factory CustomResponse.loading() =>
      CustomResponse<T>._(status: CustomResponseStatus.loading);

  factory CustomResponse.success({String? message, T? data}) =>
      CustomResponse<T>._(
          message: message, status: CustomResponseStatus.success, data: data);

  factory CustomResponse.error(String message) =>
      CustomResponse._(message: message, status: CustomResponseStatus.error);

  factory CustomResponse.fromError(Map<String, dynamic> error) =>
      CustomResponse._(
        message: error['message'] as String,
        status: CustomResponseStatus.error,
      );
}

enum CustomResponseStatus { loading, success, error }
