import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobility_bap_app/screens/dropoff.dart';
import 'package:mobility_bap_app/screens/map.dart';
import 'package:mobility_bap_app/search/models/place.dart';
import 'package:mobility_bap_app/search/search_bloc.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription? locationSubscription;
  StreamSubscription? boundsSubscription;

  final _destinationController = TextEditingController();

  @override
  void initState() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);

    //Listen for selected Location
    locationSubscription =
        applicationBloc.selectedLocation!.stream.listen((Place? place) {
      if (place != null) {
        _destinationController.text = place.name ?? '';
        // _goToPlace(place);
      } else
        _destinationController.text = "";
    });
    super.initState();
  }

  @override
  void dispose() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    applicationBloc.dispose();
    _destinationController.dispose();
    locationSubscription!.cancel();
    boundsSubscription!.cancel();
    super.dispose();
  }

  // Future<void> _goToPlace(Place place) async {
  //   final GoogleMapController controller = await _mapController.future;
  //   controller.animateCamera(
  //     CameraUpdate.newCameraPosition(
  //       CameraPosition(
  //           target: LatLng(
  //               place.geometry!.location!.lat!, place.geometry!.location!.lng!),
  //           zoom: 14.0),
  //     ),
  //   );

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Scaffold(
      drawer: AppDrawer(),
      drawerEnableOpenDragGesture: false,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: MyMap(),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 30, 0, 0),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Builder(
                builder: (context) => IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(
                      Icons.menu_sharp,
                      color: Colors.black,
                    )),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height - 150,
              width: MediaQuery.of(context).size.width,
              child: DraggableScrollableSheet(
                minChildSize: 0.5,
                initialChildSize: 0.5,
                builder: (context, controller) {
                  return SingleChildScrollView(
                    controller: controller,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 150,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    topRight: Radius.circular(25),
                                  ),
                                ),
                                height: 20,
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 6,
                                  width: 60,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                color: Colors.white,
                                height: 156,
                                padding: EdgeInsets.only(top: 6, bottom: 20),
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Container(
                                        width: 50,
                                        height: 128,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Stack(
                                              children: [
                                                Image(
                                                  image: AssetImage(
                                                      "assets/images/green_loc.png"),
                                                  width: 24,
                                                ),
                                                Positioned(
                                                  top: 7,
                                                  left: 7,
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    radius: 5,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Image(
                                              image: AssetImage(
                                                  "assets/images/line.png"),
                                              width: 3,
                                              height: 36,
                                            ),
                                            Image(
                                              image: AssetImage(
                                                  "assets/images/red_loc.png"),
                                              width: 24,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        height: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border(
                                                            bottom: BorderSide(
                                                                width: 1,
                                                                color: Color(
                                                                    0xffefeff4),
                                                                style:
                                                                    BorderStyle
                                                                        .solid),
                                                          ),
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "PICKUP",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xffc8c7cc),
                                                                  fontFamily:
                                                                      'Lato',
                                                                  fontSize: 13),
                                                            ),
                                                            SizedBox(
                                                              height: 8,
                                                            ),
                                                            Text(
                                                              "Current Location",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Lato',
                                                                fontSize: 17,
                                                                color: Color(
                                                                    0xff242e42),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 8),
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        height: 68,
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "DROP OFF",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xffc8c7cc),
                                                                  fontFamily:
                                                                      'Lato',
                                                                  fontSize: 13),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width -
                                                                      170,
                                                                  height: 30,
                                                                  child:
                                                                      TextField(
                                                                    controller:
                                                                        _destinationController,
                                                                    textCapitalization:
                                                                        TextCapitalization
                                                                            .words,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintText:
                                                                          'Search by City',
                                                                      suffixIcon:
                                                                          Icon(Icons
                                                                              .search),
                                                                    ),
                                                                    onChanged: (value) =>
                                                                        applicationBloc
                                                                            .searchPlaces(value),
                                                                    // onTap: () => applicationBloc.clearSelectedLocation(),
                                                                  ),
                                                                  // Text(
                                                                  //   "Model Engineering College",
                                                                  //   style:
                                                                  //       TextStyle(
                                                                  //     fontFamily:
                                                                  //         'Lato',
                                                                  //     fontSize:
                                                                  //         17,
                                                                  //     color: Color(
                                                                  //         0xff242e42),
                                                                  //   ),
                                                                  // ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        SizedBox(
                                                                          height:
                                                                              40,
                                                                          child:
                                                                              IconButton(
                                                                            onPressed:
                                                                                () {},
                                                                            icon:
                                                                                Image(
                                                                              image: AssetImage("assets/images/close.png"),
                                                                              height: 30,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              3,
                                                                          height:
                                                                              23,
                                                                          child:
                                                                              DecoratedBox(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: Color(0xffefeff4),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              40,
                                                                          child:
                                                                              IconButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).pushNamed(Dropoff.routeName);
                                                                            },
                                                                            icon:
                                                                                Image(
                                                                              image: AssetImage("assets/images/ic_map.png"),
                                                                              height: 30,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 20,
                                width: double.infinity,
                                color: Color(0xffefefef),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white,
                                padding: const EdgeInsets.only(
                                    left: 25.0, top: 20, bottom: 20),
                                child: Text(
                                  "POPULAR LOCATIONS",
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xffc8c7cc),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount:
                                    applicationBloc.searchResults?.length,
                                //controller: controller,
                                itemBuilder: (BuildContext context, index) {
                                  return Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 1,
                                          color: Color(0xffefefef),
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image(
                                            image: AssetImage(
                                                "assets/images/red_loc.png"),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  flex: 1,
                                                  child: Text(
                                                    applicationBloc
                                                        .searchResults![index]
                                                        .description!,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontFamily: 'Lato',
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
