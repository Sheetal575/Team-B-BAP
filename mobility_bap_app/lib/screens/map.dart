import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  _MyMapState createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  late GoogleMapController mapController;
  late CameraPosition _initialLocation = CameraPosition(target: LatLng(0, 0));
  // static const LatLng _center = const LatLng(45.521345, -122.687);
  // LatLng _lastMapPosition = _center;
  late Position _currentPosition;
  String _currentAddress = '';

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();

  String _startAddress = '';
  String _destinationAddress = '';
  // String? _placeDistance;
// List of coordinates to join
  List<LatLng> polylineCoordinates = [];

// Map storing polylines created by connecting two points
  Map<PolylineId, Polyline> polylines = {};
  Set<Marker> markers = {};

  //Positions for storing start and destination
  late LatLng _startPosition;
  late LatLng _destinationPosition;

  // Start Location Marker
  Marker startMarker = Marker(
    markerId: MarkerId('startMarker'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
  );

  // Destination Location Marker
  Marker destinationMarker = Marker(
    markerId: MarkerId('destinationMarker'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
  );

  // Method for retrieving the current location
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      _currentPosition = position;
      setMarkerAndGetAddress(
          LatLng(position.latitude, position.longitude), startMarker);
    }).catchError((e) {
      print(e);
    });
  }

  //Once a marker position is modified, the address and latLng values are updated
  updateLocation(String _markerId, LatLng _latLng, String _address) {
    setState(() {
      if (_markerId == 'startMarker') {
        _startPosition = _latLng;
        _startAddress = _address;
      } else if (_markerId == 'destinationMarker') {
        _destinationAddress = _address;
        _destinationPosition = _latLng;
      }
    });
  }

  setMarkerAndGetAddress(LatLng _latLng, Marker marker) {
    print('CURRENT $_latLng');
    print('markerId ${marker.markerId}');
    // Start Location Marker
    marker = marker.copyWith(
        positionParam: LatLng(_latLng.latitude, _latLng.longitude),
        infoWindowParam: InfoWindow(
          title: marker.markerId == 'startMarker'
              ? 'PickUp point'
              : 'DropOff point',
          // snippet: _startAddress,
        ),
        draggableParam: true,
        onTapParam: () {
          print(_latLng);
        },
        onDragEndParam: ((_newPosition) {
          print('${_newPosition.latitude} + ${_newPosition.longitude}');
          _getAddress(LatLng(_newPosition.latitude, _newPosition.longitude))
              .then((_address) {
            print(_address);
            updateLocation(marker.markerId.value, _newPosition, _address);
          });
        }));
    setState(() {
      _getAddress(LatLng(_latLng.latitude, _latLng.longitude)).then((_address) {
        print(_address);
        updateLocation(marker.markerId.value,
            LatLng(_latLng.latitude, _latLng.longitude), _address);
      });
      markers.add(marker);
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(_latLng.latitude, _latLng.longitude),
            zoom: 18.0,
          ),
        ),
      );
    });
  }

  // Method for retrieving the address
  Future<String> _getAddress(LatLng latLng) async {
    try {
      List<Placemark> p =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      Placemark place = p[0];
      return "${place.name}, ${place.street}, ${place.locality}";
    } catch (e) {
      print(e);
      return 'error';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  //text field widget
  Widget _textField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
    required double width,
    required Icon prefixIcon,
    Widget? suffixIcon,
    required Function(String) locationCallback,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: TextField(
        onChanged: (value) {
          locationCallback(value);
        },
        controller: controller,
        focusNode: focusNode,
        decoration: new InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.blue.shade300,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.all(15),
          hintText: hint,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('start: $_startAddress dropoff: $_destinationAddress');
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: Scaffold(
        // key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            // Map View

            GoogleMap(
              onLongPress: (_latLng) {
                setMarkerAndGetAddress(_latLng, destinationMarker);
              },
              markers: Set<Marker>.from(markers),
              initialCameraPosition: _initialLocation,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              // polylines: Set<Polyline>.of(polylines.values),
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
                _getCurrentLocation();
              },
            ),
            // Show zoom buttons
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                      child: Material(
                        color: Colors.blue.shade100, // button color
                        child: InkWell(
                          splashColor: Colors.blue, // inkwell color
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Icon(Icons.add),
                          ),
                          onTap: () {
                            mapController.animateCamera(
                              CameraUpdate.zoomIn(),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ClipOval(
                      child: Material(
                        color: Colors.blue.shade100, // button color
                        child: InkWell(
                          splashColor: Colors.blue, // inkwell color
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Icon(Icons.remove),
                          ),
                          onTap: () {
                            mapController.animateCamera(
                              CameraUpdate.zoomOut(),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Show the place input fields & button for
            // showing the route
            // SafeArea(
            //   child: Align(
            //     alignment: Alignment.topCenter,
            //     child: Padding(
            //       padding: const EdgeInsets.only(top: 10.0),
            //       child: Container(
            //         decoration: BoxDecoration(
            //           color: Colors.white70,
            //           borderRadius: BorderRadius.all(
            //             Radius.circular(20.0),
            //           ),
            //         ),
            //         width: width * 0.9,
            //         child: Padding(
            //           padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            //           child: Column(
            //             mainAxisSize: MainAxisSize.min,
            //             children: <Widget>[
            //               Text(
            //                 'Places',
            //                 style: TextStyle(fontSize: 20.0),
            //               ),
            //               SizedBox(height: 10),
            //               _textField(
            //                   label: 'Start',
            //                   hint: 'Choose starting point',
            //                   prefixIcon: Icon(Icons.looks_one),
            //                   suffixIcon: IconButton(
            //                     icon: Icon(Icons.my_location),
            //                     onPressed: () {
            //                       startAddressController.text = _currentAddress;
            //                       _startAddress = _currentAddress;
            //                     },
            //                   ),
            //                   controller: startAddressController,
            //                   focusNode: startAddressFocusNode,
            //                   width: width,
            //                   locationCallback: (String value) {
            //                     setState(() {
            //                       _startAddress = value;
            //                     });
            //                   }),
            //               SizedBox(height: 10),
            //               _textField(
            //                   label: 'Destination',
            //                   hint: 'Choose destination',
            //                   prefixIcon: Icon(Icons.looks_two),
            //                   controller: destinationAddressController,
            //                   focusNode: desrinationAddressFocusNode,
            //                   width: width,
            //                   locationCallback: (String value) {
            //                     setState(() {
            //                       _destinationAddress = value;
            //                     });
            //                   }),
            //               SizedBox(height: 10),
            //               Visibility(
            //                 visible: _placeDistance == null ? false : true,
            //                 child: Text(
            //                   'DISTANCE: $_placeDistance km',
            //                   style: TextStyle(
            //                     fontSize: 16,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 ),
            //               ),
            //               SizedBox(height: 5),
            //               ElevatedButton(
            //                 onPressed: (){
            //                   showPlaces();
            //                   },
            //                 child: Padding(
            //                   padding: const EdgeInsets.all(8.0),
            //                   child: Text(
            //                     'Show Route'.toUpperCase(),
            //                     style: TextStyle(
            //                       color: Colors.white,
            //                       fontSize: 20.0,
            //                     ),
            //                   ),
            //                 ),
            //                 style: ElevatedButton.styleFrom(
            //                   primary: Colors.red,
            //                   shape: RoundedRectangleBorder(
            //                     borderRadius: BorderRadius.circular(20.0),
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // Show current location button
            SafeArea(
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                  child: ClipOval(
                    child: Material(
                      // elevation: 5,
                      color: Colors.blue.shade100, // button color
                      child: InkWell(
                        splashColor: Colors.blue, // inkwell color
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(Icons.my_location),
                        ),
                        onTap: () {
                          mapController.animateCamera(
                            CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: LatLng(
                                  _currentPosition.latitude,
                                  _currentPosition.longitude,
                                ),
                                zoom: 18.0,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
