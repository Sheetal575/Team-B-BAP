import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mobility_bap_app/services/auth.dart';

class AuthLogic with ChangeNotifier {
  var _otp = 0;

  final _tokenService = AuthService();

  Map<String, String> get _headers => {
        "Content-Type": "application/json",
        "Accept": "application/json",
      };

  Uri _getUrl(String endpoint) {
    return Uri.http('13.232.151.174:54545', endpoint);
  }

  Future signUp(String username, String phoneNumber) async {
    final Uri url = this._getUrl('/api/auth/register/user');
    try {
      final response = await http.post(
        url,
        headers: _headers,
        body: jsonEncode({'phoneNumber': phoneNumber, 'username': username}),
      );
      var json = await jsonDecode(response.body);
      if (json['success'] == false) {
        print(json['message']);
        return json;
      } else {
        print(json);
        return {'success': true, 'otp': json['otp']};
        //this json contains the otp
      }
    } catch (error) {
      return {'success': false, 'message': error.toString()};
    }
  }

  Future signIn(String phoneNumber) async {
    final Uri url = this._getUrl('/api/auth/login');
    try {
      final response = await http.post(
        url,
        headers: this._headers,
        body: jsonEncode({'phoneNumber': phoneNumber}),
      );
      final json = await jsonDecode(response.body);
      if (json['success'] == false) {
        print(json['message']);
        return json;
      } else {
        print(json);
        return {'success': true, 'otp': json['otp']};
      }
    } catch (error) {
      return {'success': false, 'message': error.toString()};
    }
  }

  Future checkLoginOtp(String typedOTP, String phoneNumber) async {
    final Uri url = this._getUrl('/api/auth/verifyLogin');
    try {
      await _tokenService.clearToken();
      final response = await http.patch(
        url,
        headers: this._headers,
        body: jsonEncode({
          'userPhoneNumber': phoneNumber,
          'userOtp': typedOTP,
        }),
      );
      final json = await jsonDecode(response.body);
      //print("hi");
      print(json);
      if (json['success']) {
        await _tokenService.setToken(json['accessToken']);
      }
      return json;
      //Set isVerified to true for user

    } catch (error) {
      print(error.toString());
      return {'success': false, 'message': error.toString()};
    }
  }

  Future checkSignUpOtp(String typedOTP, String phoneNumber) async {
    final Uri url = this._getUrl('/api/auth/verifyOtp');
    try {
      await _tokenService.clearToken();
      final response = await http.patch(
        url,
        headers: this._headers,
        body: jsonEncode({
          'userPhoneNumber': phoneNumber,
          'userOtp': typedOTP,
        }),
      );
      final json = jsonDecode(response.body);
      // if (json['success'] == false) {
      //   print(json['message']);
      //   return json["message"];
      // } else {
      //   return '1';
      //   //Set isVerified to true for user
      //}
      if (json['success']) {
        await _tokenService.setToken(json['accessToken']);
      }

      return json;
      //Set isVerified to true for user

    } catch (error) {
      print(error.toString());
      return {'success': false, 'message': error.toString()};
    }
  }
}
