import 'package:dio/dio.dart';
import 'api_config.dart';
import 'exceptions.dart';


class PaymentService {
late final Dio _dio;


PaymentService() {
_dio = Dio(
BaseOptions(
baseUrl: ApiConfig.baseUrl,
connectTimeout: const Duration(seconds: 10),
receiveTimeout: const Duration(seconds: 12),
),
);
}


Future<Map<String, dynamic>> initiatePayment({required int amount, required String userId}) async {
try {
final response = await _dio.post(
'/payments',
data: {
'amount': amount,
'currency': 'INR',
'receipt': 'rcpt_$userId',
'userId': userId,
},
);


return Map<String, dynamic>.from(response.data);
} on DioException catch (e) {
throw ApiException(e.message ?? 'Payment failed');
}
}


Future<bool> recordTransaction(Map<String, dynamic> payload) async {
try {
final res = await _dio.post('/payments/record', data: payload);
return res.statusCode == 200;
} catch (e) {
throw ApiException('Failed to record transaction');
}
}
}