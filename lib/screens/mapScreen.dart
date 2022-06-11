// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fua/locationService.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  var textController = TextEditingController();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-1.286389, 36.817223),
    zoom: 14.4746,
  );

  final Set<Marker> _markers = Set<Marker>();
  final Set<Polygon> _polygon = Set<Polygon>();
  List<LatLng> polygonLatLngs = <LatLng>[];
  int _polygonCounter = 1;

  // static final Marker _kGooglePlexMarker = Marker(
  //   markerId: MarkerId("_kGooglePlex"),
  //   infoWindow: InfoWindow(title: "Google Plex"),
  //   icon: BitmapDescriptor.defaultMarker,
  //   position: LatLng(37.42796133580664, -122.085749655962),
  // );

  // static final Marker lake = Marker(
  //   markerId: MarkerId("_kGooglePlex"),
  //   infoWindow: InfoWindow(title: "Google Plex"),
  //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
  //   position: LatLng(37.43296265331129, -122.08832357078792),
  // );
  static final CameraPosition _kLake = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(-1.286389, 36.817223),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  // static final Polyline polyline = Polyline(
  //   polylineId: PolylineId("_kGooglePlexMarker"),
  //   points: [
  //     LatLng(37.43296265331129, -122.08832357078792),
  //     LatLng(37.42796133580664, -122.085749655962),
  //   ],
  //   width: 5,
  // );

  // static final Polygon polygon = Polygon(
  //   polygonId: PolygonId("polygon"),
  //   points: [
  //     LatLng(37.43296265331129, -122.08832357078792),
  //     LatLng(37.42796133580664, -122.085749655962),
  //     LatLng(37.418, -122.092),
  //     LatLng(37.435, -122.092),
  //   ],
  //   strokeWidth: 5,
  //   fillColor: Colors.transparent,
  // );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setMarker(LatLng(-1.286389, 36.817223));
  }

  void _setMarker(LatLng points) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('marker'),
          position: points,
        ),
      );
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: double.maxFinite,
                  child: TextField(
                    controller: textController,
                    textCapitalization: TextCapitalization.words,
                    onChanged: (value) {
                      //Do something with the user input.
                      print(value);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Your Current Location',
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.lightBlueAccent, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      ),
                      // suffixIcon: Center(child: Icon(Icons.search)),
                    ),
                  ),
                ),
              ),
              IconButton(
                iconSize: 30,
                color: Color.fromARGB(255, 216, 232, 245),
                onPressed: () async {
                  var place =
                      await LocationService().getPlace(textController.text);
                  goToPlace(place);
                },
                icon: const Icon(Icons.search),
              ),
            ],
          ),
        ),
        Expanded(
          child: GoogleMap(
            markers: _markers,
            // _kGooglePlexMarker,

            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            // polylines: {polyline},
            // polygons: {polygon},
          ),
        ),
      ],

      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: _goToTheLake,
      //   label: const Text('To the lake!'),
      //   icon: const Icon(Icons.directions_boat),
      // ),
    );
  }

  Future<void> goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            lat,
            lng,
          ),
          zoom: 12,
        ),
      ),
    );
    _setMarker(LatLng(lat, lng));
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}


//11.00