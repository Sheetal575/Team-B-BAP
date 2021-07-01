import 'package:flutter/material.dart';
import 'package:mobility_bap_app/models/token.dart';
import 'package:mobility_bap_app/screens/auth_screen.dart';
import 'package:mobility_bap_app/screens/dropoff.dart';
import 'package:mobility_bap_app/screens/onboarding.dart';
import 'package:mobility_bap_app/services/auth.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //AuthService().signOut();
    //final token = Provider.of<Token?>(context);
    return FutureBuilder(
        future: AuthService().getToken(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) return OnBoarding();
          return AuthScreen();
        });
    //if (token == null) return AuthScreen();
    //return OnBoarding();
  }
}
