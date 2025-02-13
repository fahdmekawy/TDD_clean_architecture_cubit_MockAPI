import 'package:equatable/equatable.dart';

class ApiException extends Equatable implements Exception {
  final int statusCode;
  final String message;

  const ApiException({
    required this.statusCode,
    required this.message,
  });

  @override
  List<Object?> get props => [message, statusCode];
}
