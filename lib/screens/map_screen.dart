import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:location_finder/providers/location_provider.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<LocationProvider>(context, listen: false).getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Location Finder')), 
      body: locationProvider.currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(locationProvider.currentLocation!.latitude!, locationProvider.currentLocation!.longitude!),
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('current_location'),
                  position: LatLng(locationProvider.currentLocation!.latitude!, locationProvider.currentLocation!.longitude!),
                  infoWindow: InfoWindow(title: 'You are here'),
                ),
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await locationProvider.findNearbyPlaces('restaurant');
           if (locationProvider.nearbyPlaces.isNotEmpty){
            showDialog(context: context, builder: (context) => AlertDialog(
              title: Text('Nearby Places'),
              content: Text('Found ${locationProvider.nearbyPlaces.length} restaurants'),
              actions: [TextButton(onPressed: ()=> Navigator.pop(context), child: Text('OK'))],
            ));
          }
        },
        child: Icon(Icons.restaurant),
      ),
    );
  }
}