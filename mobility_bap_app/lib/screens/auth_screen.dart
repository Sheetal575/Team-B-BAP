import 'package:flutter/material.dart';
import 'package:mobility_bap_app/screens/phone_verify_screen.dart';
import 'package:provider/provider.dart';

import 'package:mobility_bap_app/services/auth_logic.dart';

enum AuthMode { Signup, SignIn }

class AuthScreen extends StatelessWidget {
  AuthScreen();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).primaryColor,
                  ),
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    top: MediaQuery.of(context).size.height / 2 -
                        256, //Size of Image
                    child: Image.asset(
                      'assets/images/Group2.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 2 - 100,
                    child: AuthCard(),
                  ),
                  Positioned(
                    bottom: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                          'By clicking start, you agree to our Terms and Conditions'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _errController = TextEditingController();

  AuthMode _authMode = AuthMode.Signup;

  Map<String, String> _authData = {
    'userName': '',
    'mobileNo': '',
  };

  Future<void> _submit() async {
    _formKey.currentState!.save();
    if (!_formKey.currentState!.validate()) return;

    if (_authMode == AuthMode.SignIn) {
      // Sign In Function
      dynamic res = await Provider.of<AuthLogic>(context, listen: false).signIn(
        _authData['mobileNo']!,
      );
      if (!res['success']) {
        print(res);
        setState(() {
          _errController.text = res['message'];
        });
      } else {
        Navigator.of(context).pushReplacementNamed(
          PhoneVerifyScreen.routeName,
          arguments: ['SIGNIN', _authData['mobileNo']!],
        );
      }
    } else {
      //Sign Up Function
      dynamic res = await Provider.of<AuthLogic>(context, listen: false).signUp(
        _authData['userName']!,
        _authData['mobileNo']!,
      );
      if (!res['success']) {
        print(res);
        setState(() {
          _errController.text = res['message'];
        });
      } else {
        Navigator.of(context).pushReplacementNamed(
          PhoneVerifyScreen.routeName,
          arguments: ['SIGNUP', _authData['mobileNo']!],
        );
      }
    }
  }

  void _switchAuthMode(int mode) {
    if (mode == 1) {
      setState(() {
        _errController.clear();
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _errController.clear();
        _authMode = AuthMode.SignIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10.0,
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width - 20,
        height: MediaQuery.of(context).size.height * 0.4,
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          _switchAuthMode(1);
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              color: _authMode == AuthMode.Signup
                                  ? Colors.black
                                  : Colors.grey),
                        ),
                      ),
                      if (_authMode == AuthMode.Signup)
                        Container(
                          height: 4.5,
                          width: 45,
                          color: Theme.of(context).primaryColor,
                        )
                    ],
                  ),
                  Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          _switchAuthMode(0);
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                              color: _authMode == AuthMode.Signup
                                  ? Colors.grey
                                  : Colors.black),
                        ),
                      ),
                      if (_authMode == AuthMode.SignIn)
                        Container(
                          height: 4.5,
                          width: 45,
                          color: Theme.of(context).primaryColor,
                        )
                    ],
                  )
                ],
              ),
              Divider(),
              Text(_errController.text),
              _authMode == AuthMode.Signup
                  ? Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.grey, // set border color
                            width: 0.3), // set border width
                        borderRadius: BorderRadius.all(
                            Radius.circular(7.0)), // set rounded corner radius
                      ),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'username',
                          border: InputBorder.none,
                          errorStyle: TextStyle(fontSize: 12, height: 0.2),
                        ),
                        onSaved: (value) {
                          _authData['userName'] = value!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    )
                  : Text('Login with your phone number'),
              Container(
                padding: EdgeInsets.only(
                  left: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.grey, // set border color
                      width: 0.3), // set border width
                  borderRadius: BorderRadius.all(
                      Radius.circular(7.0)), // set rounded corner radius
                ),
                child: Row(
                  children: [
                    Text(' +91  '),
                    Flexible(
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Mobile Number',
                          border: InputBorder.none,
                          errorStyle: TextStyle(fontSize: 12, height: 0.2),
                        ),
                        onSaved: (value) {
                          _authData['mobileNo'] = value!;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          if (value.characters.length != 10) {
                            return 'Invalid mobile number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor),
                  onPressed: _submit,
                  child:
                      Text(_authMode == AuthMode.Signup ? 'Sign Up' : 'Next'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
