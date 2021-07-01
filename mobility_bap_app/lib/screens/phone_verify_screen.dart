import 'package:flutter/material.dart';
import 'package:mobility_bap_app/services/auth_logic.dart';
import 'package:provider/provider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PhoneVerifyScreen extends StatefulWidget {
  static const routeName = '/phone-verify-screen';

  PhoneVerifyScreen({Key? key}) : super(key: key);

  @override
  _PhoneVerifyScreenState createState() => _PhoneVerifyScreenState();
}

class _PhoneVerifyScreenState extends State<PhoneVerifyScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _errController = TextEditingController();

  var _otp = ' ';

  void _submit(String checker, String phoneNumber) async {
    _errController.clear();
    _formKey.currentState!.save();
    if (!_formKey.currentState!.validate()) return;
    if (checker == 'SIGNIN') {
      dynamic res = await Provider.of<AuthLogic>(context, listen: false)
          .checkLoginOtp(_otp, phoneNumber);
      if (res['success']) {
        print('SUCCESS');
        Navigator.pushReplacementNamed(context, '/');
      } else {
        print(res);
        setState(() {
          _errController.text = res['message'];
        });
      }
    } else {
      dynamic res = await Provider.of<AuthLogic>(context, listen: false)
          .checkSignUpOtp(_otp, phoneNumber);
      if (res['success']) {
        print('SUCCESS');
        Navigator.pushReplacementNamed(context, '/');
      } else {
        print(res);
        setState(() {
          _errController.text = res['message'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _data = ModalRoute.of(context)!.settings.arguments as List<String>;
    var _checker = _data[0];
    var _phoneNumber = _data[1];
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                      //Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_new_rounded),
                    color: Colors.white,
                  ),
                  Text(
                    'Phone Verification',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    'Enter your OTP code here',
                    style: TextStyle(
                      letterSpacing: 2,
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            ),
            Text(_errController.text),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              padding: EdgeInsets.symmetric(
                vertical: 30,
              ),
              child: Form(
                key: _formKey,
                child: PinCodeTextField(
                  blinkWhenObscuring: false,
                  obscuringWidget: CircleAvatar(
                    radius: 5,
                    backgroundColor: Colors.black87,
                  ),
                  keyboardType: TextInputType.number,
                  appContext: context,
                  length: 4,
                  onChanged: (value) {
                    //print(value);
                    //_otp = int.parse(value);
                  },
                  onSaved: (value) {
                    _otp = value!;
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    activeColor: Colors.grey,
                    inactiveColor: Colors.grey,
                    disabledColor: Colors.grey,
                    selectedColor: Colors.grey,
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(40),
              child: ElevatedButton(
                onPressed: () {
                  _submit(_checker, _phoneNumber);
                  print(_data);
                  //Navigator.of(context).pop();
                },
                child: Text('Verify Now'),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
