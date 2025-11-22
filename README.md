# Location Finder App

A Flutter app that uses GPS to find nearby locations using Google Places API.

## Features

*   Gets the user's current location.
*   Finds nearby restaurants, parks, etc.
*   Displays the locations on a Google Map.
*   Stores search history in a local SQLite database.

## Dependencies

*   geolocator
*   google_maps_flutter
*   http
*   provider
*   geocoding
*   flutter_dotenv
*   sqflite
*   path_provider

## Setup

1.  Clone the repository.
2.  Run `flutter pub get`.
3.  Create a `.env` file in the root directory and add your Google Maps API key:
    
    GOOGLE_MAPS_API_KEY=YOUR_API_KEY
    
4.  Run the app.