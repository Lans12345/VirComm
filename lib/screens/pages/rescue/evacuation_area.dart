import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../plugins/geolocator.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

late double lat;
late double long;

class MapSampleState extends State<MapSample> {
  @override
  void initState() {
    super.initState();
    permission();
    getLocation();
    marker1();
    marker2();
    marker3();
  }

  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      lat = position.latitude;
      long = position.longitude;
    });
    print('lat - $lat');
    print('long - $long');
  }

  final Completer<GoogleMapController> _controller = Completer();
  static CameraPosition myLocation = CameraPosition(
    target: LatLng(lat, long),
    zoom: 16,
  );

  Set<Marker> markers = {};

  marker1() async {
    Marker mark1 = Marker(
        markerId: const MarkerId('mark1'),
        infoWindow: const InfoWindow(
          title: 'Your Location',
        ),
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(lat, long));

    setState(() {
      markers.add(mark1);
    });
  }

  marker2() async {
    Marker mark2 = Marker(
        markerId: const MarkerId('mark2'),
        infoWindow: const InfoWindow(
          title: 'Evacuation Area 1',
        ),
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(lat, long));

    setState(() {
      markers.add(mark2);
    });
  }

  marker3() async {
    Marker mark3 = Marker(
        markerId: const MarkerId('mark3'),
        infoWindow: const InfoWindow(
          title: 'Evacuation Area 2',
        ),
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(lat, long));

    setState(() {
      markers.add(mark3);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        zoomControlsEnabled: false,
        markers: Set<Marker>.from(markers),
        mapType: MapType.normal,
        initialCameraPosition: myLocation,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
