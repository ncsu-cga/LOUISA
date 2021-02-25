import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';

class MapCurrentLocation extends StatefulWidget {
  final LatLng center;
  final MapController mapController;

  MapCurrentLocation(this.center, this.mapController);

  @override
  _MapCurrentLocationState createState() => _MapCurrentLocationState();
}

class _MapCurrentLocationState extends State<MapCurrentLocation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.0),
        Container(
          height: 200,
          child: FlutterMap(
            options: MapOptions(
              center: widget.center,
              zoom: 17.0,
            ),
            mapController: widget.mapController,
            layers: [
              TileLayerOptions(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c']),
              MarkerLayerOptions(markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: widget.center,
                  builder: (ctx) => Container(
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40.0,
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
      ],
    );
  }
}
