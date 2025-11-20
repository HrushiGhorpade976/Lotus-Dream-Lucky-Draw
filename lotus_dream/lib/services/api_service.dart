import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/models/draw_model.dart';

class ApiService {
  static const baseUrl = 'https://your-backend-api.com';

  Future<List<Draw>> fetchDraws() async {
    final res = await http.get(Uri.parse('$baseUrl/draws'));
    if (res.statusCode == 200) {
      final List<dynamic> data = jsonDecode(res.body);
      return data.map((e) => Draw.fromJson(e)).toList();
    }
    throw Exception('Failed to fetch draws');
  }

  Future<Draw> joinDraw(String drawId, String userId) async {
    final res = await http.post(
      Uri.parse('$baseUrl/draws/$drawId/join'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userId': userId}),
    );
    if (res.statusCode == 200) return Draw.fromJson(jsonDecode(res.body));
    throw Exception('Failed to join draw');
  }
}
