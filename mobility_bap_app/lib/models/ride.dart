import 'package:geolocator/geolocator.dart';

class RideDetails {
  String? startAddress;
  String? destinationAddress;
  Position? startPosition;
  Position? destinationPosition;

  RideDetails({
    this.startAddress,
    this.startPosition,
    this.destinationAddress,
    this.destinationPosition,
  });
}
