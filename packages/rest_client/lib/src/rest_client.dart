import 'package:http/http.dart' as http;

import 'package:rest_client/src/rest_client_base.dart';

/// {@template rest_client}
/// A REST client for making HTTP requests.
/// {@endtemplate}
abstract class RestClient {
  /// {@macro rest_client}
  factory RestClient({
    required String baseUrl,
    http.Client? client,
  }) = RestClientBase;

  /// Sends a GET request to the given [path].
  Future<Map<String, Object?>> get(
    String path, {
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
  });

  /// Sends a POST request to the given [path].
  Future<Map<String, Object?>> post(
    String path, {
    required Map<String, Object?> body,
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
  });

  /// Sends a PUT request to the given [path].
  Future<Map<String, Object?>> put(
    String path, {
    required Map<String, Object?> body,
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
  });

  /// Sends a DELETE request to the given [path].
  Future<Map<String, Object?>> delete(
    String path, {
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
  });

  /// Sends a PATCH request to the given [path].
  Future<Map<String, Object?>> patch(
    String path, {
    required Map<String, Object?> body,
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
  });
}
