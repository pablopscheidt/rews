import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mapa de Alagamentos")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(-27.5954, -48.5480),
          zoom: 12,
        ),
      ),
    );
  }
}
