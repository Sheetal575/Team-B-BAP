import 'package:flutter/material.dart';
import 'package:mobility_bap_app/screens/setup_gps_location_screen.dart';

class OnBoarding extends StatefulWidget {
  static const routeName = '/onboarding-screen';
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    const headings = ["Request Ride", "Confirm Your Driver", "Track your ride"];
    const desc = [
      "Request a ride get picked up by a nearby community driver",
      "Huge drivers network helps you find comforable, safe and cheap ride",
      "Know your driver in advance and be able to view current location in real time on the map"
    ];
    const images = [
      "assets/images/request.png",
      "assets/images/confirm.png",
      "assets/images/track.png"
    ];
    double topFactor = 0.108;
    if (MediaQuery.of(context).size.height > 720) topFactor = 0.140;
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! < 0 && this._counter < 2) {
            this._incrementCounter();
          } else if (details.primaryVelocity! > 0 && this._counter > 0) {
            this._decrementCounter();
          }
        },
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Theme.of(context).accentColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: topFactor * MediaQuery.of(context).size.height,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage(images[this._counter]),
                    radius: (MediaQuery.of(context).size.height * 0.34) / 2,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.08),
                    child: Text(
                      headings[this._counter],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.04,
                        horizontal: 50),
                    child: Text(
                      desc[this._counter],
                      style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 17,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  this._counter == 2 ? OnboardingButton() : SizedBox()
                ],
              ),
            ),
            Positioned(
              bottom: 30,
              left: (MediaQuery.of(context).size.width / 2) - 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFEFEFF4),
                        borderRadius: BorderRadiusDirectional.horizontal(
                            start: Radius.circular(10),
                            end: Radius.circular(10))),
                    width: 90,
                    height: 6,
                    child: Row(
                      children: [
                        buildNavContainer(0),
                        buildNavContainer(1),
                        buildNavContainer(2),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildNavContainer(int i) {
    return Container(
      decoration: BoxDecoration(
          color: i == this._counter ? Theme.of(context).primaryColor : null,
          borderRadius: BorderRadiusDirectional.horizontal(
              start: Radius.circular(10), end: Radius.circular(10))),
      width: 30,
    );
  }
}

class OnboardingButton extends StatelessWidget {
  const OnboardingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).pushReplacementNamed(
            '/my-account-screen'); //(SetupGpsLocationScreen.routeName);
      },
      child: Text(
        "GET STARTED!",
        style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w900,
            fontSize: 17),
      ),
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        backgroundColor: MaterialStateProperty.resolveWith(
            (states) => Theme.of(context).primaryColor),
        minimumSize:
            MaterialStateProperty.resolveWith((states) => Size(190, 45)),
      ),
    );
  }
}
