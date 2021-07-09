// ignore: avoid_web_libraries_in_flutter
// import 'dart:html';
import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map/src/map/map.dart';
import 'package:lat_lon_grid_plugin/lat_lon_grid_plugin.dart';
import 'package:latlong/latlong.dart';
import 'MGRS_grid_plugin.dart';
import 'button_layer_plugin.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MaterialApp(
    home: GridMap(),
  ));
}

class GridMap extends StatefulWidget {
  const GridMap({Key key}) : super(key: key);

  @override
  _GridMapState createState() => _GridMapState();
}

class _GridMapState extends State<GridMap> {
  double zoomLevel = 8.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //     });
      //   },
      //   child: Icon(Icons.add),
      // ),
      body: Center(
        child: FlutterMap(
          options: MapOptions(
            center: LatLng(35.00, 135.00),
            zoom: 5.0,
            plugins: [
              MGRSGridPlugin(),
              ButtonLayerPlugin(),
              // MapPluginLatLonGrid(),
            ],
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            // MapPluginLatLonGridOptions(
            //   lineColor: Colors.green,
            //   textColor: Colors.white,
            //   lineWidth: 0.5,
            //   textBackgroundColor: Colors.green,
            //   showCardinalDirections: true,
            //   showCardinalDirectionsAsPrefix: false,
            //   textSize: 12.0,
            //   showLabels: true,
            //   rotateLonLabels: true,
            //   placeLabelsOnLines: true,
            //   offsetLonTextBottom: 20.0,
            //   offsetLatTextLeft: 20.0,
            // ),
            MGRSGridPluginOption(),
            // ButtonLayerPluginOption(),
            // MarkerLayerOptions(
            //   markers: [
            //     Marker(
            //       width: 20.0,
            //       height: 20.0,
            //       //comment
            //       point: LatLng(35.00, 135.00),
            //       builder: (ctx) => new Container(
            //         child: FloatingActionButton(
            //           onPressed: () {
            //             print('PRESSED!');
            //           },
            //         ),
            //       ),
            //     ),
          ],
        ),
      ),
    );
  }
}
