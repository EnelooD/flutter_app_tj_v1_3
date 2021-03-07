import 'package:flutter/material.dart';
import 'package:flutter_app_tj_v1_3/screens/drawer.dart';
import 'package:flutter_app_tj_v1_3/utils/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:location/location.dart';

class MapUI extends StatefulWidget {
  @override
  _MapUIState createState() => _MapUIState();
}

class _MapUIState extends State<MapUI> {
  @override
  double lat;
  double lng;

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _srartPosition = CameraPosition(
    target: LatLng(18.6942644,97.6685739),
    zoom: 50.0,
  );

  Set<Marker> marker = Set<Marker>();
  LocationData currentLocation;

  void initState(){

    lat = 13.7067544;
    lng = 100.3551793;

    marker.add(
      Marker(
        markerId: MarkerId('cs1'),
        position: LatLng(
            lat,lng
        ),
        infoWindow: InfoWindow(
          title: 'comsci sau',
          snippet: 'computer',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueCyan
        ),
      ),
    );

    toCurrentLocation();

    super.initState();
  }

  Future<LocationData> getCurrentLocation() async{
    Location location = Location();
    try{
      return await location.getLocation();
    }catch(e){
      print('เปิด');
      return null;
    }
  }
  //เคลื่อนย้ายตำแหน่งบน map มายัง CurrentLocation
  Future toCurrentLocation() async{
    GoogleMapController controller = await _controller.future;
    currentLocation = await getCurrentLocation();
    setState(() {
      lat = currentLocation.latitude;
      lng = currentLocation.longitude;
    });
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            lat,
            lng,
          ),
          zoom: 14,
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: DrawerAom(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0.0,
        title: Text(
          'MAP',
          style: Constants.titleStyle,
        ),
      ),
      body:Container(
        padding: const EdgeInsets.only(top: 90),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: Theme.of(context).brightness == Brightness.light
                ? Constants.lightBGColors
                : Constants.darkBGColors,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Container(
                child: Container(
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.brown),
                        ),
                        onPressed: () {
                          // Navigator.pushNamed(context, '/screen/detail_ui');
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Search',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                height: MediaQuery.of(context).size.height * 0.7,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _srartPosition,
                  onMapCreated: (controller){
                    _controller.complete(controller);
                  },
                  markers: marker,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
