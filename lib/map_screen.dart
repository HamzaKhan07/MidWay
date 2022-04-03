import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'location_brain.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'checkInternet.dart';
import 'route_helper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MapScreen extends StatefulWidget {
  final LatLng midpoint;
  final String midpointAddress;
  MapScreen({this.midpoint, this.midpointAddress});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool routesMarked = false;
  List<LatLng> polylinePoints = [];
  Set<Polyline> _polyline = HashSet<Polyline>();
  bool isVisible = false;
  bool isLoading = false;
  bool initLoading = false;
  Set<Marker> _markers = HashSet<Marker>();
  GoogleMapController _mapController;
  BitmapDescriptor _markerA,
      _markerB,
      _markerC,
      _markerD,
      _markerE,
      _markerF,
      _markerG,
      _markerH,
      _markerI,
      _markerJ,
      _markerK,
      _markerL,
      _markerM,
      _markerN,
      _markerO,
      _markerP,
      _markerQ,
      _markerR,
      _markerS,
      _markerT,
      _markerU,
      _markerV,
      _markerW,
      _markerX,
      _markerY,
      _markerZ,
      _markerMid;

  @override
  void initState() {
    super.initState();
    setInitConfig();
  }

  void setInitConfig() async {
    setState(() {
      initLoading = true;
    });
    await setIcons();
    setState(() {
      initLoading = false;
    });
  }

  BitmapDescriptor getIcon(String initialChar) {
    initialChar = initialChar.toLowerCase();
    switch (initialChar) {
      case 'a':
        return _markerA;
        break;

      case 'b':
        return _markerB;
        break;

      case 'c':
        return _markerC;
        break;

      case 'd':
        return _markerD;
        break;

      case 'e':
        return _markerE;
        break;

      case 'f':
        return _markerF;
        break;

      case 'g':
        return _markerG;
        break;

      case 'h':
        return _markerH;
        break;

      case 'i':
        return _markerI;
        break;

      case 'J':
        return _markerJ;
        break;

      case 'k':
        return _markerK;
        break;

      case 'l':
        return _markerL;
        break;

      case 'm':
        return _markerM;
        break;

      case 'n':
        return _markerN;
        break;

      case 'o':
        return _markerO;
        break;

      case 'p':
        return _markerP;
        break;

      case 'q':
        return _markerQ;
        break;

      case 'r':
        return _markerR;
        break;

      case 's':
        return _markerS;
        break;

      case 't':
        return _markerT;
        break;

      case 'u':
        return _markerU;
        break;

      case 'v':
        return _markerV;
        break;

      case 'w':
        return _markerW;
        break;

      case 'x':
        return _markerX;
        break;

      case 'y':
        return _markerY;
        break;

      case 'z':
        return _markerZ;
        break;

      default:
        return _markerA;
    }
  }

  Future<void> setIcons() async {
    _markerA = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker-a.png');
    _markerB = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker-b.png');
    _markerC = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker-c.png');
    _markerD = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker-d.png');
    _markerE = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker-e.png');
    _markerF = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker-f.png');
    _markerG = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker-g.png');
    _markerH = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker-h.png');
    _markerI = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker-i.png');
    _markerJ = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker-j.png');
    _markerK = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker-k.png');
    _markerL = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker-l.png');
    _markerM = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker-m.png');
    _markerN = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker-n.png');
    _markerO = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker-o.png');
    _markerP = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker-p.png');
    _markerQ = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker-q.png');
    _markerR = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker-r.png');
    _markerS = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker-s.png');
    _markerT = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker-t.png');
    _markerU = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker-u.png');
    _markerV = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker-v.png');
    _markerW = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker-w.png');
    _markerX = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker-x.png');
    _markerY = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker-y.png');
    _markerZ = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker-z.png');
    _markerMid = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), 'assets/images/marker-mid.png');
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    setState(() {
      //Add all the locations
      //show loading on the map itself
      isLoading = true;
      var data = Provider.of<LocationBrain>(context, listen: false).getData();
      for (int i = 0; i < data.length; i++) {
        _markers.add(
          Marker(
            icon: getIcon(data[i].name.trim().substring(0, 1)),
            markerId: MarkerId("$i"),
            position: data[i].coordinates,
            infoWindow: InfoWindow(
              title: '${data[i].name.trim()}',
              snippet: '${data[i].address}',
            ),
          ),
        );
      }
      //add mid location
      _markers.add(
        Marker(
          onTap: () {
            print('tapped');
            if (isVisible == false) {
              setState(() {
                isVisible = true;
              });
            } else {
              setState(() {
                isVisible = false;
              });
            }
          },
          icon: _markerMid,
          markerId: MarkerId("Mid"),
          position: LatLng(widget.midpoint.latitude, widget.midpoint.longitude),
          infoWindow: InfoWindow(
            title: 'Mid Location',
            snippet: widget.midpointAddress,
          ),
        ),
      );
      //hide loading on the map.
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    void drawRoute(String id) {
      setState(() {
        _polyline.add(
          Polyline(
            polylineId: PolylineId(id),
            points: polylinePoints,
            visible: true,
            color: Colors.black,
            width: 5,
          ),
        );
      });
    }

    return ModalProgressHUD(
      inAsyncCall: initLoading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            'Map',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
          ),
        ),
        body: Stack(
          children: [
            GoogleMap(
              polylines: _polyline,
              markers: _markers,
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target:
                    LatLng(widget.midpoint.latitude, widget.midpoint.longitude),
                zoom: 12,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: ModalProgressHUD(
                  color: Colors.black,
                  inAsyncCall: isLoading,
                  child: Container(),
                ),
              ),
            ),
            Visibility(
              visible: isVisible,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  width: 200,
                  height: 100,
                  child: AutoSizeText(
                    'Address: ${widget.midpointAddress}',
                    maxLines: 5,
                    minFontSize: 6.0,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 60.0, 20.0),
                child: OutlinedButton(
                  onPressed: () async {
                    //plot route
                    try {
                      if (await CheckInternet().isInternet() == true) {
                        if (routesMarked == false) {
                          setState(() {
                            isLoading = true;
                          });
                          List<LatLng> locations =
                              Provider.of<LocationBrain>(context, listen: false)
                                  .getLocationData();

                          //draw routes from all the locations
                          for (int i = 0; i < locations.length; i++) {
                            List points = await RouteHelper().getCoordinates(
                                widget.midpoint.latitude,
                                widget.midpoint.longitude,
                                locations[i].latitude,
                                locations[i].longitude);

                            if (points != null) {
                              for (int j = 0; j < points.length; j++) {
                                polylinePoints
                                    .add(LatLng(points[j][1], points[j][0]));
                              }
                              //again go back to the starting point to avoid straight line in between
                              List<LatLng> temp = polylinePoints;
                              polylinePoints.addAll(temp.reversed.toList());
                              //check id
                              drawRoute('route$i');
                            } else {
                              print("Points is Null");
                            }
                          }
                          //hide loading
                          setState(() {
                            isLoading = false;
                          });
                          routesMarked = true;
                        } else {
                          //do nothing
                        }
                      } else {
                        //show error
                        _showError(context, 'No Internet',
                            'Make sure Internet is ON.');
                        print('Internet is not available.');
                      }
                    } catch (error) {
                      //hide loading
                      setState(() {
                        isLoading = false;
                      });
                      _showError(context, 'Oops Something Went Wrong!',
                          'Please try Again.');
                      print('Error occured $error');
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Route',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 14.0),
                      ),
                      Icon(
                        Icons.navigation,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
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
