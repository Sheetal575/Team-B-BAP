import 'package:flutter/cupertino.dart';
import 'package:mobility_bap_app/models/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends ChangeNotifier {
  Future setToken(String tkn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', tkn);
    print("set");
    notifyListeners();
  }

  Future<Token?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //await setToken('1234');
    try {
      String? token = await prefs.getString('token');
      if (token == null) return null;
      return Token(true, token.toString());
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Stream<Token?> get validToken async* {
    final t = await getToken();
    yield t;
  }

  Future clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future signOut(ctx) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacementNamed(ctx, '/');
    notifyListeners();
  }
}
