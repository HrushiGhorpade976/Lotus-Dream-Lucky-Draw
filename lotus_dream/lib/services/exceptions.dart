class ApiException implements Exception {
final String message;
final int? statusCode;
ApiException(this.message, {this.statusCode});


@override
String toString() => 'ApiException(status: $statusCode, message: $message)';
}


class NetworkException extends ApiException {
NetworkException(String message) : super(message);
}


class TimeoutExceptionApi extends ApiException {
TimeoutExceptionApi(String message) : super(message);
}