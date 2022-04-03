import 'package:flutter/material.dart';
import 'LocationCard.dart';
import 'map_screen.dart';
import 'select_name.dart';
import 'package:provider/provider.dart';
import 'location_brain.dart';
import 'package:geocoding/geocoding.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'midpoint_getter.dart';
import 'package:location/location.dart' as loc;
import 'checkInternet.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:geocoder/geocoder.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    checkLocationGranted();
  }

  void checkLocationGranted() async {
    loc.Location location = loc.Location();
    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.grey,
      inAsyncCall: isLoading,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SelectName()));
          },
        ),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Add \nLocation',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Poppins',
                            fontSize: 30.0,
                          ),
                        ),
                      ),
                      Visibility(
                        visible:
                            Provider.of<LocationBrain>(context).getSize() > 1
                                ? true
                                : false,
                        child: GestureDetector(
                          onTap: () async {
                            //show loading
                            print('Loading');
                            setState(() {
                              isLoading = true;
                            });

                            if (await CheckInternet().isInternet() == true) {
                              //Check if country is same for all locations
                              var country = '';
                              var data = Provider.of<LocationBrain>(context,
                                      listen: false)
                                  .getLocationData();

                              for (int i = 0; i < data.length; i++) {
                                var lat = data[i].latitude;
                                var long = data[i].longitude;
                                var entryCountry;
                                try {
                                  List<Placemark> placemarks =
                                      await placemarkFromCoordinates(lat, long);
                                  entryCountry = placemarks[0].country;
                                  print('Index $i: ' + entryCountry);
                                } catch (error) {}

                                if (country == '') {
                                  country = entryCountry;
                                } else {
                                  if (country != entryCountry) {
                                    //show error here and dont go ahead.
                                    print('All country names are not same');
                                    setState(() {
                                      isLoading = false;
                                    });
                                    _showError(
                                        context,
                                        'Different Countries Detected',
                                        'Make sure all entries have same Country.');
                                    return;
                                  }
                                }
                              }
                              //get mid location
                              var midpoint = MidpointGetter().getCenterLatLong(
                                  Provider.of<LocationBrain>(context,
                                          listen: false)
                                      .getLocationData());

                              print('Midpoint: $midpoint');
                              var coordinates = Coordinates(
                                  midpoint.latitude, midpoint.longitude);
                              //Get Midpoint Address
                              var midAddress = '';

                              try {
                                var addresses = await Geocoder.local
                                    .findAddressesFromCoordinates(coordinates);
                                midAddress =
                                    addresses.first.addressLine.toString();

                                print('MidAddress: $midAddress');
                              } catch (error) {}

                              //hide loading
                              print('Loading finished');
                              setState(() {
                                isLoading = false;
                              });
                              //navigate to map screen

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MapScreen(
                                            midpoint: midpoint,
                                            midpointAddress: midAddress,
                                          )));
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              //show Internet error
                              _showError(context, 'Oops, Something went wrong.',
                                  'Make sure the Internet is On and Try Again.');
                            }
                          },
                          child: CircleAvatar(
                            radius: 25.0,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.navigation,
                              size: 25.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                    ),
                    child: Container(
                      child: ListView.builder(
                        itemCount:
                            Provider.of<LocationBrain>(context).data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return LocationCard(
                            name: Provider.of<LocationBrain>(context,
                                    listen: false)
                                .data[index]
                                .name,
                            address: Provider.of<LocationBrain>(context,
                                    listen: false)
                                .data[index]
                                .address,
                            onLongTap: () {
                              Provider.of<LocationBrain>(context, listen: false)
                                  .deleteEntries(index);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_showError(context, title, desc) {
  Alert(
    context: context,
    type: AlertType.error,
    title: title,
    desc: desc,
    buttons: [
      DialogButton(
        color: Colors.black,
        child: Text(
          "OK",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Poppins',
          ),
        ),
        onPressed: () => Navigator.pop(context),
        width: 120,
      )
    ],
  ).show();
}
