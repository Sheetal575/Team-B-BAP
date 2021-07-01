import 'package:flutter/material.dart';

class SetupGpsLocationScreen extends StatelessWidget {
  static const routeName = '/setup-gps-location-screen';
  const SetupGpsLocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            child: Image.asset(
              'assets/images/setupGpsLocation.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          Text(
            'Hi, nice to meet you!',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50),
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.near_me_sharp),
              label: Text('Use current location'),
              style: OutlinedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                side: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              'Select it manually',
              style: TextStyle(
                color: Colors.red,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
