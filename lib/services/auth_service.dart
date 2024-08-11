import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String signupUrl = 'http://localhost:8080/api/auth/signup';
  static const String loginUrl = 'http://localhost:8080/api/auth/login';
  static const String otpVerifyUrl = 'http://localhost:8080/api/auth/verify';
  
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
      Map<String, dynamic> errorResponse = jsonDecode(response.body);
      throw Exception(errorResponse['message']?? 'Failed to sign up : Please Try Again' );
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
      return jsonDecode(response.body)['statusMsg'];
    } else {
      Map<String, dynamic> errorResponse = jsonDecode(response.body);
      throw Exception(errorResponse['message']?? 'Failed to login : Please Try Again' );
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
      Map<String, dynamic> errorResponse = jsonDecode(response.body);
      throw Exception(errorResponse['message']?? 'Failed to verify OTP : Please Try Again' );
    }
  }
}
