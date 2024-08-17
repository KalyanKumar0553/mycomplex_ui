import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mycomplex_ui/constants.dart';
import 'package:mycomplex_ui/helper/shared_preferences_helper.dart';

class AuthService {
  
  static const String baseURL = 'https://mycomplex-api.azurewebsites.net';
  static const String signupUrl = baseURL + '/api/auth/signup';
  static const String loginUrl = baseURL + '/api/auth/login';
  static const String otpVerifyUrl = baseURL + '/api/auth/verify';
  static const String resetPasswordUrl = baseURL + '/api/auth/reset_pasword';
  static const String sendOTPUrl = baseURL + '/api/auth/send_otp';
  static const String logoutUrl = baseURL + '/api/auth/logout';

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
      print('errorResponse');
      print(errorResponse['message']);
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
      throw Exception(errorResponse['message'] ?? 'Failed to verify OTP : Please Try Again' );
    }
  }

  Future<Map<String, dynamic>> resetPassword(Map<String, dynamic> payload) async {
    final response = await http.post(
      Uri.parse(resetPasswordUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      Map<String, dynamic> errorResponse = jsonDecode(response.body);
      throw Exception(errorResponse['message']?? 'Failed to Reset Password : Please Try Again' );
    }
  }

  Future<Map<String, dynamic>> sendOTP(Map<String, dynamic> payload) async {
    final response = await http.post(
      Uri.parse(sendOTPUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(payload),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      Map<String, dynamic> errorResponse = jsonDecode(response.body);
      throw Exception(errorResponse['message']?? 'Failed to Send OTP : Please Try Again' );
    }
  }

    Future<Map<String, dynamic>> logout(Map<String, dynamic> payload) async {
      String bearerToken = await SharedPreferencesHelper.getValue(SharedPreferencesKeys.bearerTokenKey) ?? '';
      final response = await http.post(
        Uri.parse(logoutUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': bearerToken ,
        },
        body: jsonEncode(payload),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['statusMsg'];
      } else {
        Map<String, dynamic> errorResponse = jsonDecode(response.body);
        throw Exception(errorResponse['message']?? 'Failed to logout : Please Try Again' );
      }
  }
}
