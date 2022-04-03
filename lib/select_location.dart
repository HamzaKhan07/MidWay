import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'getSuggestions.dart';
import 'package:provider/provider.dart';
import 'location_brain.dart';

class SelectLocation extends StatefulWidget {
  final name;
  SelectLocation({this.name});
  @override
  _SelectLocationState createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  TextEditingController controller = TextEditingController();
  var lat, long, place;
  GetSuggestions suggest = GetSuggestions();
  Location location = Location();
  LocationData locationData;

  @override
  void initState() {
    super.initState();
    getLocation();
    print("init of Ending");
  }

  void getLocation() async {
    locationData = await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          'Enter Location',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              child: TypeAheadField(
                hideOnEmpty: true,
                textFieldConfiguration: TextFieldConfiguration(
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.location_on, color: Colors.black),
                    ),
                    icon: null,
                    hintText: 'Enter your Location',
                    helperStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.0,
                    ),
                    labelStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.0,
                    ),
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18.0,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                ),
                suggestionsCallback: (pattern) {
                  print(pattern);
                  if (pattern.length > 0 && locationData != null) {
                    return suggest.getSuggest(
                        pattern, locationData.latitude, locationData.longitude);
                  } else {
                    return null;
                  }
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    leading: Icon(Icons.location_on_outlined),
                    title: Text(suggestion['title']),
                    //subtitle: Text('\$${suggestion['price']}'),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  lat = (suggestion['position']['lat']);
                  long = (suggestion['position']['lng']);
                  place = (suggestion['title']);

                  if (lat != null && long != null && place != null) {
                    //Here is the location
                    print('Lat: $lat');
                    print('Long: $long');
                    print('Place: $place');
                    print('Name: ${widget.name}');
                    var latlng = LatLng(lat, long);
                    //add data to provider
                    Provider.of<LocationBrain>(context, listen: false)
                        .addData(widget.name, place, latlng);
                    Provider.of<LocationBrain>(context, listen: false)
                        .addLocation(latlng);
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
