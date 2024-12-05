import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});


  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapScreen> {
  List<LatLng> routePoints = [];
  LatLng startPoint = const  LatLng(40.7128, -74.0060); // Punto inicial
  LatLng endPoint =  const LatLng(40.730610, -73.935242);

  @override
  void initState() {
    super.initState();
    fetchRoute();
  }

  Future<void> fetchRoute() async {
    const url = 'http://router.project-osrm.org/route/v1/driving/-74.0060,40.7128;-73.935242,40.730610?overview=full&geometries=geojson';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> coordinates = data['routes'][0]['geometry']['coordinates'];

      setState(() {
        routePoints = coordinates.map((coord) {
          return LatLng(coord[1], coord[0]); // Invertir el orden a latitud, longitud
        }).toList();
      });
    } else {
      throw Exception('Error al cargar la ruta');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ruta en OpenStreetMap')),
      body: FlutterMap(
    options: const MapOptions(
      initialCenter: LatLng(40.7128, -74.0060), // Center the map over London
      initialZoom: 12,
    ),
    children: [
      TileLayer( // Display map tiles from any source
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
        userAgentPackageName: 'com.example.app',
        maxNativeZoom: 19, // Scale tiles when the server doesn't support higher zoom levels
        // And many more recommended properties!
      ),
        PolylineLayer(
        polylines: [
          Polyline(
            points: routePoints,
            strokeWidth: 4.0,
            color: Colors.black87,
          ),
        ],
      ),
      MarkerLayer(
            markers: [
                Marker(
                  point: startPoint,
                  width: 80,
                  height: 80,
                  child:  const Icon(
                    Icons.location_on,
                    color: Colors.blueGrey,
                    size: 40.0,
                  )
                ),
                Marker(
                  point: endPoint,
                  width: 80,
                  height: 80,
                  child:  const Icon(
                    Icons.location_city_sharp,
                    color: Colors.orangeAccent,
                    size: 40.0,
                  )
                ),
                
            ],
          ),
    ],
  )

    );
  }
}