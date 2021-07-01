import 'package:flutter/material.dart';
import 'package:mobility_bap_app/models/token.dart';
import 'package:mobility_bap_app/models/user.dart';
import 'package:mobility_bap_app/services/api.dart';
import 'package:mobility_bap_app/services/auth.dart';
import 'package:provider/provider.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}) : super(key: key);
  static const routeName = '/my-account-screen';
  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  dynamic _token;
  @override
  void initState() {
    super.initState();
    _token = AuthService().getToken();
  }

  @override
  Widget build(BuildContext context) {
    if (_token == null) {
      print("No token");
      AuthService().signOut(context);
    }
    return Scaffold(
      body: FutureBuilder<User?>(
          future: ApiService(_token).getUserDetails(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Column(
                children: [
                  Text("Loading"),
                  TextButton(
                      onPressed: () {
                        AuthService().signOut(context);
                      },
                      child: Text("sign out"))
                ],
              );
            }
            return Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back_ios_new_rounded),
                        color: Colors.white,
                      ),
                      Text(
                        'My Account',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Divider(),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Text("Name"),
                        Spacer(),
                        Text(
                          snapshot.data!.name,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 20),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Text('Email'),
                        Spacer(),
                        Text(
                          snapshot.data!.email,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 20),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Text('Gender'),
                        Spacer(),
                        Text(
                          snapshot.data!.gender,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 20),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Text('Phone number'),
                        Spacer(),
                        Text(
                          snapshot.data!.phone,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(width: MediaQuery.of(context).size.width / 20),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
