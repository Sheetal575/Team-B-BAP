import 'package:mobility_bap_app/search/models/location_model.dart';

class Geometry {
  final Location? location;

  Geometry({this.location});

  Geometry.fromJson(Map<dynamic, dynamic> parsedJson)
      : location = Location.fromJson(parsedJson['location']);
}
