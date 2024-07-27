import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String signupUrl = '/api/auth/signup';

  Future<Map<String, dynamic>> signUp(Map<String, dynamic> payload) async {
    final response = await http.post(
      Uri.parse(signupUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(payload),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to sign up');
    }
  }
}
