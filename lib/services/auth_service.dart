import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String signupUrl = '/api/auth/signup';
  static const String loginUrl = '/api/auth/login';
  static const String otpVerifyUrl = '/api/auth/verify';
  
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

  Future<Map<String, dynamic>> login(Map<String, dynamic> payload) async {
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> verifyOtp(Map<String, dynamic> payload) async {
    final response = await http.post(
      Uri.parse(otpVerifyUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to verify OTP: ${response.body}');
    }
  }
}
