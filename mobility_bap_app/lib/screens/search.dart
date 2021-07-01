import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:mobility_bap_app/screens/map.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:provider/provider.dart';


class serachForMap extends StatefulWidget {
  const serachForMap({ Key? key }) : super(key: key);

  @override
  _serachForMapState createState() => _serachForMapState();
}

class _serachForMapState extends State<serachForMap> {
  TextEditingController pickUpTextEditingController = TextEditingController();
  TextEditingController pickOffTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // String placeAddress = Provider.of<AppData>(context).pickUpLocation.placeName ?? "";
    // pickUpTextEditingController.text = placeAddress;
    return Container(
      child: Scaffold(
        // key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top:70.0,left:20.0,right: 20.0),
              child: TextField(
                onTap: ()async{
                  
                    const kGoogleApiKey = "AIzaSyChUalbolsCwsV_Rg93cbscl6hpvQbWsOA";

                    Prediction? p = await PlacesAutocomplete.show(
                                              context: context,
                                              apiKey: kGoogleApiKey,
                                              mode: Mode.overlay, // Mode.fullscreen
                                              language: "en",
                                              components: [new Component(Component.country, "in")]);

                                      
                },
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your location'
              ),
      ),)]))
    );
  }
}


// void findPlace(String placeName) async{
//   if(placeName.length >1){
//     String autoCompleteUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=AIzaSyChUalbolsCwsV_Rg93cbscl6hpvQbWsOA&sessiontoken=1234567890",

//     res = await RequestAssistant.getRequest(autoCompleteUrl);
//     if(res == "failed"){
//       return;
//     }
//     print("Places Predictions Response :: ");
//     print(res);
//   }
// }