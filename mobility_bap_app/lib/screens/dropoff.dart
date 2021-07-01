import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobility_bap_app/screens/map.dart';
import 'package:google_maps_webservice/places.dart';
class Dropoff extends StatefulWidget {
  static const routeName = '/dropoff-screen';

  const Dropoff({Key? key}) : super(key: key);

  @override
  _DropoffState createState() => _DropoffState();
}

class _DropoffState extends State<Dropoff> {
  final _locationContoller = TextEditingController(text: "Model Engineering College");
   late GoogleMapController mapController;
   static const kGoogleApiKey = "AIzaSyBrN9CFIe6qFV5jopUma8eWvQGgQed3t5g";
   GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  static const images = [
    {'SUV': 'assets/images/suv.png'},
    {'Hatchback': 'assets/images/hatchback.png'},
    {'Luxury Car': 'assets/images/luxury.png'},
    {'Bike': 'assets/images/bike.png'},
    {'Compact SUV': 'assets/images/electric_car.png'},
    {'MUV': 'assets/images/muv.png'},
  ];

  dynamic _vehicles = [
    {
      'name': 'Hatchback',
      'fare': 'Rs 200',
      'time': '2 min',
      'distance': 'Near by you',
      'top': 440.0,
      'left': 220.0
    },
    {'name': 'SUV', 'fare': 'Rs 400', 'time': '5 min', 'distance': '0.2 km'},
    {
      'name': 'Luxury Car',
      'fare': 'Rs 1000',
      'time': '3 min',
      'distance': '0.4 km',
      'top': 130.0,
      'left': 200.0
    },
    {
      'name': 'Hatchback',
      'fare': 'Rs 350',
      'time': '2 min',
      'distance': '0.45 km',
      'top': 285.0,
      'left': 280.0
    },
    {
      'name': 'Bike',
      'fare': 'Rs 80',
      'time': '3 min',
      'distance': '0.48 km',
      'top': 310.0,
      'left': 130.0
    },
    {
      'name': 'Compact SUV',
      'fare': 'Rs 250',
      'time': ' 4 min',
      'distance': '0.5 km',
      'top': 110.0,
      'left': 50.0
    },
    {
      'name': 'MUV',
      'fare': 'Rs 500',
      'time': '4 min',
      'distance': '0.67 km',
      'top': 210.0,
      'left': 20.0
    }
  ];

  dynamic pinPos = {'top': 300.0, 'left': 200.0};
  dynamic locPos = {'top': 200.0, 'left': 150.0};

  bool _applied = false;
  bool _requested = false;
  bool _changeVehicle = false;
  bool _confirmed = false;
  bool _showBookingSuccess = false;

  dynamic _selectedVehicleIndex = 3;

  void _apply() {
    setState(() {
      _applied = true;
    });
  }

  void _request() {
    setState(() {
      _requested = true;
    });
  }

  void _confirm() {
    setState(() {
      _confirmed = true;
      _showBookingSuccess = true;
    });
  }

  void _cancelRequest() {
    setState(() {
      _confirmed = false;
      _requested = false;
    });
  }

  void _closeSuccessAlert() {
    setState(() {
      _showBookingSuccess = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<PlacesSearchResult> places = [];
    int i = 0;

    String rating = '4.9';
    String recNo = '25';
    String companyName = "Cochin Taxi Services";
    String driverName = "Rajesh K R";
    String otp = "8976";
    String to = "Model Engineering College";
    String from = "Thripunithura Bus Stand";
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            MyMap(),
            // Pin(pinPos: pinPos),
            // Loc(locPos: locPos),
            if (!this._applied) ...[
              SearchBar(locationContoller: _locationContoller,),
              GPSbutton(),
              buildApplyButton(context)
            ] else ...[
              for (var v in _vehicles) Car(v: v),
              buildBackButton(),
              if (this._changeVehicle && !this._requested) ...[
                UnfocusMap(),
                buildVehiclesList(context, i)
              ] else if (!this._requested)
                buildRequestSection(context)
            ],
            if (this._requested && !this._confirmed) ...[
              ShadowBox(width: 80, height: 330),
              ShadowBox(width: 45, height: 315),
              buildAgencySection(
                  context,
                  "assets/images/person_1.png",
                  companyName,
                  rating,
                  "assets/images/person_2.png",
                  "assets/images/person_3.png",
                  "assets/images/person_4.png",
                  recNo,
                  _selectedVehicleIndex),
              buildAgencyButton(),
            ],
            if (this._confirmed) ...[
              buildBookingDetailsSection(context, "assets/images/person_1.png",
                  driverName, rating, from, to, otp),
              if (_showBookingSuccess) ...[
                UnfocusMap(),
                buildBookingSuccessAlert(
                    context, _vehicles[_selectedVehicleIndex]['time'])
              ],
            ],
          ],
        ),
      ),
    );
  }

  Positioned buildBookingDetailsSection(BuildContext context, String img,
      String name, String rating, String from, String to, String otp) {
    return Positioned(
      bottom: 8,
      child: Container(
        height: 345,
        width: MediaQuery.of(context).size.width - 25,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Column(
          children: [
            DetailRow(img: img, name: name, rating: rating),
            Container(
              height: 135,
              child: Stack(
                children: [
                  Container(
                    height: 121,
                    width: MediaQuery.of(context).size.width - 25,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1, color: Color(0xffefeff4)))),
                    child: Row(
                      children: [
                        BookingDetailUI(),
                        Expanded(child: FromTo(from: from, to: to)),
                      ],
                    ),
                  ),
                  OTPbutton(otp: otp)
                ],
              ),
            ),
            RideRow(
                img: "assets/images/hatchback.png",
                distance: "0.2 km",
                time: "2 min",
                price: "Rs 350"),
            buildCancelRequestButton()
          ],
        ),
      ),
    );
  }

  SizedBox buildCancelRequestButton() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(28))),
          child: TextButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.resolveWith((states) => Colors.black),
            ),
            onPressed: _cancelRequest,
            child: Text(
              "Cancel Request",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Positioned buildBookingSuccessAlert(BuildContext context, String time) {
    return Positioned(
      top: (MediaQuery.of(context).size.height / 2) - 190,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(18))),
        width: 320,
        height: 340,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Container(
                width: double.infinity,
                height: 245,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/images/check.png",
                      ),
                      backgroundColor: Colors.white,
                      radius: 72,
                    ),
                    Text(
                      "Booking Successful",
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w900,
                          fontSize: 20),
                    ),
                    Column(
                      children: [
                        Text(
                          "Your booking has been confirmed",
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400,
                            color: Color(0xff8a8a8f),
                          ),
                        ),
                        Text(
                          "Driver will pick you up in " + time,
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Lato',
                            fontWeight: FontWeight.w400,
                            color: Color(0xff8a8a8f),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1, color: Color(0xffefeff4)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 159.5,
                    height: double.infinity,
                    child: TextButton(
                      onPressed: _closeSuccessAlert,
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w900,
                          fontSize: 17,
                          color: Color(0xffc8c7cc),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 1,
                    height: double.infinity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Color(0xffefeff4)),
                    ),
                  ),
                  SizedBox(
                    height: double.infinity,
                    width: 159.5,
                    child: TextButton(
                      onPressed: _closeSuccessAlert,
                      child: Text(
                        "Done",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w900,
                          fontSize: 17,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Positioned buildAgencyButton() {
    return Positioned(
      bottom: 360,
      child: SizedBox(
        width: 239,
        height: 35,
        child: TextButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.resolveWith((states) => Colors.white)),
          onPressed: () {},
          child: Text(
            "Select Your Agency",
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w900,
                color: Color(0xff242e42),
                fontSize: 17),
          ),
        ),
      ),
    );
  }

  Positioned buildAgencySection(
      BuildContext context,
      String companyImg,
      String companyName,
      String rating,
      String recImg1,
      String recImg2,
      String recImg3,
      String recNo,
      int index) {
    final vehicle = _vehicles[index]['name'];
    final distance = _vehicles[index]['distance'];
    final price = _vehicles[index]['fare'];
    final time = _vehicles[index]['time'];
    String img = "assets/images/hatchback.png";
    for (var i in images) {
      if (i.containsKey(vehicle)) {
        img = i[vehicle].toString();
        break;
      }
    }
    return Positioned(
      bottom: 8,
      child: Container(
        width: MediaQuery.of(context).size.width - 25,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, -5),
                blurRadius: 20,
                color: Colors.grey.withOpacity(0.9)),
          ],
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          children: [
            DetailRow(
              img: companyImg,
              name: companyName,
              rating: rating,
            ),
            Container(
              width: double.infinity,
              height: 85,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(recImg1),
                      radius: 15,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(recImg2),
                      radius: 15,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(recImg3),
                      radius: 15,
                    ),
                  ),
                  Text(
                    recNo + " Recommended",
                    style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff242e42),
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        width: 2.0,
                        color: Color(0xffefeff4),
                        style: BorderStyle.solid),
                    bottom: BorderSide(
                        width: 2.0,
                        color: Color(0xffefeff4),
                        style: BorderStyle.solid)),
              ),
            ),
            RideRow(img: img, distance: distance, time: time, price: price),
            buildConfirmButton(context)
          ],
        ),
      ),
    );
  }

  Padding buildConfirmButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: () {
            this._confirm();
          },
          child: Text(
            "Confirm",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 17,
                fontFamily: 'Roboto'),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                  (states) => Theme.of(context).primaryColor)),
        ),
      ),
    );
  }

  Positioned buildBackButton() {
    return Positioned(
      top: 15,
      left: 23,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: IconButton(
          onPressed: () {
            if (this._changeVehicle) {
              setState(() {
                this._changeVehicle = false;
              });
              return;
            }
            if (this._applied && !this._requested) {
              setState(() {
                this._applied = false;
              });
              return;
            }
            if (this._requested && !this._confirmed) {
              setState(() {
                this._requested = false;
              });
            }
            if (this._requested && this._confirmed) {
              setState(() {
                this._confirmed = false;
                this._requested = false;
              });
            }
          },
          icon: Image(
            image: AssetImage("assets/images/left_arrow.png"),
          ),
        ),
      ),
    );
  }

  Positioned buildVehiclesList(BuildContext context, int i) {
    return Positioned(
      bottom: 0,
      child: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            setState(() {
              _changeVehicle = false;
            });
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            color: Colors.white,
          ),
          height: 485,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 25, top: 9, bottom: 10),
                    child: Transform.rotate(
                      angle: pi / 8,
                      child: SizedBox(
                        height: 6,
                        width: 30,
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(10),
                                  right: Radius.circular(10))),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25, top: 9, bottom: 10),
                    child: Transform.rotate(
                      angle: -pi / 8,
                      child: SizedBox(
                        height: 6,
                        width: 30,
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(10),
                                  right: Radius.circular(10))),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              for (var v in _vehicles)
                buildVehicleRow(context, i,
                    i++ == this._selectedVehicleIndex ? true : false, false),
            ],
          ),
        ),
      ),
    );
  }

  Positioned buildRequestSection(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        color: Color(0xFFf7f7f7),
        width: MediaQuery.of(context).size.width,
        height: 240,
        child: Column(
          children: [
            buildSelectedVehicle(context),
            buildOptions(),
            buildRequestButton(context)
          ],
        ),
      ),
    );
  }

  GestureDetector buildSelectedVehicle(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! < 0) {
          setState(() {
            _changeVehicle = true;
          });
        }
      },
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: SizedBox(
                width: 57,
                height: 6,
                child: const DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(10), right: Radius.circular(10)),
                  ),
                ),
              ),
            ),
            buildVehicleRow(context, this._selectedVehicleIndex, false, true),
          ],
        ),
      ),
    );
  }

  GestureDetector buildVehicleRow(
      BuildContext context, int index, bool isActive, bool highFare) {
    final vehicle = _vehicles[index]['name'];
    final distance = _vehicles[index]['distance'];
    final fare = _vehicles[index]['fare'];
    final time = _vehicles[index]['time'];
    String img = 'assets/images/hatchback.png';
    for (var i in images) {
      if (i.containsKey(vehicle)) {
        img = i[vehicle].toString();
        break;
      }
    }
    void _selectNewVehicle(int index) {
      if (index == this._selectedVehicleIndex && this._changeVehicle) {
        setState(() {
          this._changeVehicle = false;
        });
        return;
      }
      this._changeVehicle = false;
      if (index == this._selectedVehicleIndex) {
        this.setState(() {
          _changeVehicle = true;
        });
        return;
      }
      this.setState(() {
        _selectedVehicleIndex = index;
      });
    }

    return GestureDetector(
      onTap: () {
        _selectNewVehicle(index);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context).primaryColor : null,
          border: Border(
            bottom: BorderSide(
                width: 1, color: Color(0xFFefeff4), style: BorderStyle.solid),
          ),
        ),
        height: 65,
        child: Row(
          children: [
            Container(
              width: 84,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Image(
                  image: AssetImage(img),
                  color: isActive ? Colors.white : null,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 84,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vehicle,
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w900,
                              color: isActive ? Colors.white : null),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          distance,
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Lato',
                            color: isActive ? Colors.white : Color(0xFFc8c7cc),
                          ),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          fare,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: highFare
                                ? Color(0xFFf52d56)
                                : isActive
                                    ? Colors.white
                                    : null,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          time,
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Lato',
                            color: isActive ? Colors.white : Color(0xFFc8c7cc),
                          ),
                          textAlign: TextAlign.right,
                        )
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

  Container buildOptions() {
    const TextStyle t = TextStyle(
      fontSize: 15,
      fontFamily: 'Lato',
      color: Color(0xFF8a8a8f),
    );
    return Container(
      color: Colors.white,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Image.asset("assets/images/wallet.png"),
                ),
                Text("Payment", style: t)
              ],
            ),
            SizedBox(
              width: 2,
              height: 33,
              child: const DecoratedBox(
                decoration: const BoxDecoration(color: Color(0xFFf2f2f2)),
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Image.asset("assets/images/ticket.png"),
                ),
                Text(
                  "Promotions",
                  style: t,
                )
              ],
            ),
            SizedBox(
              width: 2,
              height: 33,
              child: const DecoratedBox(
                decoration: const BoxDecoration(color: Color(0xFFf2f2f2)),
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Image.asset("assets/images/options.png"),
                ),
                Text(
                  "Options",
                  style: t,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding buildRequestButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        height: 45,
        child: TextButton(
          onPressed: () {
            this._request();
          },
          child: Text(
            "Request",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto',
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                  (states) => Theme.of(context).primaryColor)),
        ),
      ),
    );
  }

  Positioned buildApplyButton(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        height: 65,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: TextButton(
            onPressed: () {
              this._apply();
            },
            child: Text(
              "Apply",
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(
                    (states) => Theme.of(context).primaryColor)),
          ),
        ),
      ),
    );
  }
}

class OTPbutton extends StatelessWidget {
  const OTPbutton({
    Key? key,
    required this.otp,
  }) : super(key: key);

  final String otp;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 110,
        left: ((MediaQuery.of(context).size.width - 25) / 2) - 80,
        child: Container(
          alignment: Alignment.center,
          width: 160,
          height: 22,
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Text(
            "Your Ride OTP is " + otp,
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Lato',
                fontWeight: FontWeight.bold,
                fontSize: 12),
          ),
        ));
  }
}

class FromTo extends StatelessWidget {
  const FromTo({
    Key? key,
    required this.from,
    required this.to,
  }) : super(key: key);

  final String from;
  final String to;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 1,
                              color: Color(0xffefeff4),
                              style: BorderStyle.solid),
                        ),
                      ),
                      child: Text(
                        from,
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 17,
                          color: Color(0xff242e42),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 60,
                      decoration: BoxDecoration(),
                      child: Text(
                        to,
                        style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 17,
                            color: Color(0xff242e42)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookingDetailUI extends StatelessWidget {
  const BookingDetailUI({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 4,
            ),
            Stack(
              children: [
                Image(
                  image: AssetImage("assets/images/green_loc.png"),
                  width: 24,
                ),
                Positioned(
                  top: 7,
                  left: 7,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 5,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 0,
              width: 2,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 7,
              width: 2,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Color(0xffc8c7cc)),
              ),
            ),
            SizedBox(
              height: 4,
              width: 2,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 7,
              width: 2,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Color(0xffc8c7cc)),
              ),
            ),
            SizedBox(
              height: 4,
              width: 2,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 7,
              width: 2,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Color(0xffc8c7cc)),
              ),
            ),
            SizedBox(
              height: 0,
              width: 2,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.white),
              ),
            ),
            Image(
              image: AssetImage("assets/images/red_loc.png"),
              width: 24,
            ),
          ],
        ),
      ),
    );
  }
}

class RideRow extends StatelessWidget {
  const RideRow({
    Key? key,
    required this.img,
    required this.distance,
    required this.time,
    required this.price,
  }) : super(key: key);

  final String img;
  final distance;
  final time;
  final price;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image(
            image: AssetImage(img),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Distance",
                style: TextStyle(
                    fontSize: 13,
                    color: Color(0xffc8c7cc),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                distance,
                style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff242e42),
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Time",
                style: TextStyle(
                    fontSize: 13,
                    color: Color(0xffc8c7cc),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                time,
                style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff242e42),
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Price",
                style: TextStyle(
                    fontSize: 13,
                    color: Color(0xffc8c7cc),
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                price,
                style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff242e42),
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String img;
  final String rating;
  final String name;
  const DetailRow(
      {Key? key, required this.img, required this.name, required this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 90,
      color: Color(0xFFf7f7f7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 20.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(this.img),
              radius: 25,
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 169,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            name,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 17,
                                color: Color(0xff242e42),
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Text(
                            rating,
                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0xffc8c7cc),
                                fontFamily: 'Roboto Mono',
                                fontWeight: FontWeight.w400),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/call.png"),
                      radius: 20,
                    ),
                    iconSize: 70,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShadowBox extends StatelessWidget {
  const ShadowBox({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 8,
      child: Container(
        width: MediaQuery.of(context).size.width - width,
        height: height,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, -5),
                  blurRadius: 20,
                  color: Colors.grey.withOpacity(0.9)),
            ],
            color: Color(0xFFf7f7f7),
            borderRadius: BorderRadius.all(Radius.circular(8))),
      ),
    );
  }
}

class Car extends StatelessWidget {
  const Car({
    Key? key,
    required this.v,
  }) : super(key: key);

  final v;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: v['top'],
      left: v['left'],
      child: SizedBox(
        width: 100,
        child: Image(image: AssetImage("assets/images/car.png")),
      ),
    );
  }
}

class Loc extends StatelessWidget {
  const Loc({
    Key? key,
    required this.locPos,
  }) : super(key: key);

  final locPos;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: this.locPos['top'],
      left: this.locPos['left'],
      child: SizedBox(
        width: 100,
        child: Image(
          image: AssetImage("assets/images/current_loc.png"),
        ),
      ),
    );
  }
}

class UnfocusMap extends StatelessWidget {
  const UnfocusMap({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: new BoxDecoration(color: Color(0xFF191919).withOpacity(0.3)),
    );
  }
}

class Pin extends StatelessWidget {
  const Pin({
    Key? key,
    required this.pinPos,
  }) : super(key: key);

  final pinPos;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: pinPos['top'],
      left: pinPos['left'],
      child: SizedBox(
        width: 100,
        child: Image(image: AssetImage("assets/images/pin.png")),
      ),
    );
  }
}

class GPSbutton extends StatelessWidget {
  const GPSbutton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 100,
      right: 15,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: IconButton(
            onPressed: () {},
            icon: Image(image: AssetImage("assets/images/gps.png"))),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    required TextEditingController locationContoller,
  })  : _locationContoller = locationContoller,
        super(key: key);

  final TextEditingController _locationContoller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 5,
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 10), color: Color.fromRGBO(0, 0, 0, 0.1))
          ],
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {},
                icon: Image.asset("assets/images/left_arrow.png")),
            Container(
              width: 160, //200
              child: TextField(
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                controller: _locationContoller,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400),
              ),
            ),
            IconButton(
                onPressed: () {}, icon: Image.asset("assets/images/close.png")),
          ],
        ),
      ),
    );
  }
}

class Map extends StatelessWidget {
  const Map({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("assets/images/map.png"),
        ),
      ),
    );
  }
}
 