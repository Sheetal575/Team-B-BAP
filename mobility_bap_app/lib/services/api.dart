import 'dart:convert';

import 'package:mobility_bap_app/models/user.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final _token;
  final Uri url = Uri.https('www.something.com', '/users', {'q': '{http}'});
  ApiService(this._token);

  Map<String, String> get _headers => {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $_token",
      };
  Future<User?> getUserDetails() async {
    try {
      var response = await http.get(this.url, headers: this._headers);
      var json = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        print(response.body);
        return User(json['name'], json['email'], json['gender'],
            json['birthday'], json['phone']);
      } else {
        print(json);
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Null> updateUserDetails(User user) async {
    try {
      var response = await http.patch(this.url,
          headers: this._headers, body: jsonEncode(user));
      var json = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        print(response.body);
        //will futurebuilder handle ui change automatically?
      } else {
        print(json);
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
