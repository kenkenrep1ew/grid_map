// ignore: avoid_web_libraries_in_flutter
// import 'dart:html';
import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map/src/map/map.dart';
import 'package:lat_lon_grid_plugin/lat_lon_grid_plugin.dart';
import 'package:latlong/latlong.dart';
import 'MGRS_grid_plugin.dart';

void main() {
  runApp(MaterialApp(
    home: GridMapPage(),
  ));
}

class GridMapPage extends StatelessWidget {
  const GridMapPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Grid Map"),
      ),
      body: GridMap(),
    );
  }
}

class GridMap extends StatefulWidget {
  const GridMap({Key key}) : super(key: key);

  @override
  _GridMapState createState() => _GridMapState();
}

class _GridMapState extends State<GridMap> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(35.00, 135.00),
          zoom: 5,
          plugins: [
            MGRSGridPlugin(),
            MapPluginLatLonGrid(),
          ],
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MapPluginLatLonGridOptions(
            lineColor: Colors.green,
            textColor: Colors.white,
            lineWidth: 0.5,
            textBackgroundColor: Colors.green,
            showCardinalDirections: true,
            showCardinalDirectionsAsPrefix: false,
            textSize: 12.0,
            showLabels: true,
            rotateLonLabels: true,
            placeLabelsOnLines: true,
            offsetLonTextBottom: 20.0,
            offsetLatTextLeft: 20.0,
          ),
          MGRSGridPluginOption(),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                //comment
                point: LatLng(40.00, 135.00),
                builder: (ctx) => new Container(
                  child: new FlutterLogo(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
