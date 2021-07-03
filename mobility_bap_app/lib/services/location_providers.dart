import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationData with ChangeNotifier {
  String startAddress = '';
  String destinationAddress = '';

  //Positions for storing start and destination
  late LatLng startPosition;
  late LatLng destinationPosition;

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

  updateLocation(String _pickupDropoff, LatLng _latLng, String _address) {
    if (_pickupDropoff == 'pickup') {
      startPosition = _latLng;
      startAddress = _address;
    } else if (_pickupDropoff == 'dropoff') {
      destinationAddress = _address;
      destinationPosition = _latLng;
    }
    notifyListeners();
  }
}
