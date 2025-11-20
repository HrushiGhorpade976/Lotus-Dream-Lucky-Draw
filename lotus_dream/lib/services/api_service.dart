import 'package:dio/dio.dart';
import 'api_config.dart';
import 'exceptions.dart';


class ApiService {
late final Dio _dio;


ApiService() {
_dio = Dio(
BaseOptions(
baseUrl: ApiConfig.baseUrl,
connectTimeout: const Duration(seconds: 10),
receiveTimeout: const Duration(seconds: 12),
sendTimeout: const Duration(seconds: 12),
headers: {
'Content-Type': 'application/json',
},
),
);


_dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
}


Future<dynamic> _safeCall(Future<Response> Function() call) async {
try {
final response = await call();


if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
return response.data;
}


throw ApiException(
'Unexpected server error',
statusCode: response.statusCode,
);
} on DioException catch (e) {
if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
throw TimeoutExceptionApi('Server timeout — try again');
}


if (e.type == DioExceptionType.connectionError) {
throw NetworkException('No internet connection');
}


throw ApiException(e.message ?? 'Unknown API Error');
}
}
// PARTICIPANT APIs
// =============================
Future<List<dynamic>> fetchParticipants() async {
final data = await _safeCall(() => _dio.get('/participants'));
return data as List<dynamic>;
}


Future<dynamic> createParticipant(Map<String, dynamic> participant) async {
return await _safeCall(() => _dio.post('/participants', data: participant));
}


Future<List<dynamic>> fetchWinners() async {
return await _safeCall(() => _dio.get('/winners'));
}


Future<dynamic> recordWinner(Map<String, dynamic> payload) async {
return await _safeCall(() => _dio.post('/winners', data: payload));
}


Future<dynamic> saveFinalists(List<String> finalistIds) async {
return await _safeCall(() => _dio.post('/finalists', data: {
'finalists': finalistIds,
}));
}


Future<Map<String, dynamic>> fetchDrawConfig() async {
final data = await _safeCall(() => _dio.get('/config/draw'));
return Map<String, dynamic>.from(data);
}


Future<double> fetchCollectedRevenue() async {
final data = await _safeCall(() => _dio.get('/payments/total'));
return double.tryParse(data.toString()) ?? 0.0;
}


Future<dynamic> postBroadcast(String message) async {
return await _safeCall(() => _dio.post('/broadcast', data: {
'message': message,
}));
}
}