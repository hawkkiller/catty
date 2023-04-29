import 'package:catty/src/core/utils/annotation.dart';
import 'package:meta/meta.dart';

@immutable
@exception
abstract class NetworkException implements Exception {}

@immutable
@exception
class RestClientException implements NetworkException {
  const RestClientException({
    this.message,
    this.statusCode,
  });

  final String? message;
  final int? statusCode;

  @override
  String toString() => 'RestClientException(message: $message, statusCode: $statusCode)';
}

@immutable
@exception
class InternalServerException implements NetworkException {
  const InternalServerException({
    this.message,
    this.statusCode,
  });

  final String? message;
  final int? statusCode;

  @override
  String toString() => 'InternalServerErrorException(message: $message, statusCode: $statusCode)';
}
