import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:location_finder/models/place.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PlacesService {
  Future<List<Place>> getNearbyPlaces(
      double latitude, double longitude, String type) async {
    final apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'];
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=1500&type=$type&key=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        return (data['results'] as List)
            .map((json) => Place.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load places: ${data['status']}');
      }
    } else {
      throw Exception('Failed to load places: ${response.statusCode}');
    }
  }
}