import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_finder/models/place.dart';
import 'package:location_finder/services/location_service.dart';
import 'package:location_finder/services/places_service.dart';

class LocationProvider with ChangeNotifier {
  Position? _currentLocation;
  List<Place> _nearbyPlaces = [];
  final LocationService _locationService = LocationService();
  final PlacesService _placesService = PlacesService();

  Position? get currentLocation => _currentLocation;
  List<Place> get nearbyPlaces => _nearbyPlaces;

  Future<void> getCurrentLocation() async {
    try {
      _currentLocation = await _locationService.getCurrentLocation();
      notifyListeners();
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  Future<void> findNearbyPlaces(String type) async {
    if (_currentLocation != null) {
      try {
        _nearbyPlaces = await _placesService.getNearbyPlaces(
            _currentLocation!.latitude!, _currentLocation!.longitude!, type);
        notifyListeners();
      } catch (e) {
        print('Error finding nearby places: $e');
      }
    }
  }
}