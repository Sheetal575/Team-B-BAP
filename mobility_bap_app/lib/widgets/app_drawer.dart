import 'package:flutter/material.dart';
import 'package:mobility_bap_app/screens/history_screen.dart';
import 'package:mobility_bap_app/screens/home_screen.dart';
import 'package:mobility_bap_app/screens/my_account_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text('App name'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                HomeScreen.routeName,
                (_) => false,
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text('History'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(HistoryScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('My Account'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(MyAccountScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout_rounded),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              //Call Logout function here
            },
          ),
        ],
      ),
    );
  }
}
