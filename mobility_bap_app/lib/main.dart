import 'package:flutter/material.dart';
import 'package:mobility_bap_app/screens/map.dart';
import 'package:mobility_bap_app/screens/search.dart';
import 'package:provider/provider.dart';

import 'package:mobility_bap_app/models/token.dart';

// import 'package:mobility_bap_app/screens/auth_screen.dart';
import 'package:mobility_bap_app/screens/dropoff.dart';
import 'package:mobility_bap_app/screens/history_screen.dart';
import 'package:mobility_bap_app/screens/home_screen.dart';
import 'package:mobility_bap_app/screens/my_account_screen.dart';
import 'package:mobility_bap_app/screens/onboarding.dart';
import 'package:mobility_bap_app/screens/phone_verify_screen.dart';
import 'package:mobility_bap_app/screens/rating_screen.dart';
import 'package:mobility_bap_app/screens/setup_gps_location_screen.dart';

import 'package:mobility_bap_app/services/auth.dart';
import 'package:mobility_bap_app/services/auth_logic.dart';

import 'package:mobility_bap_app/wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<Token?>.value(
          initialData: null,
          value: AuthService().validToken,
        ),
        ChangeNotifierProvider(
          create: (ctx) => AuthLogic(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => AuthService(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Color(0xFF4CE5B1),
          accentColor: Color(0xFFf2f2f2),
        ),
        // home: AuthWrapper(),
        home:serachForMap(),
        //AuthScreen(),
        routes: {
          OnBoarding.routeName: (ctx) => OnBoarding(),
          SetupGpsLocationScreen.routeName: (ctx) => SetupGpsLocationScreen(),
          //AuthScreen.routeName:(ctx)=>AuthScreen(),
          PhoneVerifyScreen.routeName: (ctx) => PhoneVerifyScreen(),
          Dropoff.routeName: (ctx) => Dropoff(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          MyAccountScreen.routeName: (ctx) => MyAccountScreen(),
          HistoryScreen.routeName: (ctx) => HistoryScreen(),
          RatingScreen.routeName: (ctx) => RatingScreen(),
        },
      ),
    );
  }
}
