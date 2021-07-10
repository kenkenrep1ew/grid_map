import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:grid_map/utm_zone.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/plugin_api.dart';
import 'dart:math';
import 'const_points.dart';
import 'constant.dart';
import 'lat_band.dart';
import 'my_point.dart';

class MGRSGridPluginOption extends LayerOptions {}

class MGRSGridPlugin implements MapPlugin {
  /// MapPluginLatLonGridOptions
  final MGRSGridPluginOption options;

  /// Plugin options
  MGRSGridPlugin({this.options});

  @override
  Widget createLayer(
      LayerOptions options, MapState mapState, Stream<Null> stream) {
    if (options is MGRSGridPluginOption) {
      return Center(
        child: CustomPaint(
          painter: _MyPainter(options: options, mapState: mapState),
          child: Container(),
        ),
      );
    }
    throw UnimplementedError();
  }

  @override
  bool supportsLayer(LayerOptions options) {
    return options is MGRSGridPluginOption;
    // throw UnimplementedError();
  }
}

class _MyPainter extends CustomPainter {
  double w = 0.0;
  double h = 0.0;
  MGRSGridPluginOption options;
  MapState mapState;
  final Paint mPaint = Paint();

  _MyPainter({this.options, this.mapState});

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint();
    p.color = Colors.red;

    UtmZone zone52 = UtmZone(52);
    zone52.latBands = [
      LatBand('R'),
      LatBand('S'),
    ];
    zone52.standardPoints = pointsInZone52;

    UtmZone zone53 = UtmZone(53);
    zone53.latBands = [
      LatBand('S'),
    ];
    zone53.standardPoints = pointsInZone53;

    UtmZone zone54 = UtmZone(54);
    zone54.latBands = [
      LatBand('S'),
      LatBand('T'),
    ];
    zone54.standardPoints = pointsInZone54;

    zone52.drawFrameOfUtmZone(canvas, mapState);
    zone53.drawFrameOfUtmZone(canvas, mapState);
    zone54.drawFrameOfUtmZone(canvas, mapState);

    if (zone52.westBound < mapState.center.longitude &&
        mapState.center.longitude < zone52.eastBound) {
      zone52.drawFrameByStandardPoints(canvas, mapState, size);
    }

    if (zone53.westBound < mapState.center.longitude &&
        mapState.center.longitude < zone53.eastBound) {
      zone53.drawFrameByStandardPoints(canvas, mapState, size);
      int k = zone53.standardPoints.lastIndexWhere((element) =>
          element.first.getLongitude() < mapState.center.longitude);
      int l = zone53.standardPoints[0].lastIndexWhere(
          (element) => element.getLatitude() < mapState.center.latitude);
      if (k > 0 && l > 0) {
        zone53.drawGeojsonLine(canvas, mapState, zone53.standardPoints[k][l],
            zone53.standardPoints[k + 1][l]);
        // drawGeojsonLine(canvas, mapState, bottomLeft, topLeft);
        // drawGeojsonLine(canvas, mapState, topLeft, topRight);
        // drawGeojsonLine(canvas, mapState, bottomRight, topRight);
      }
    }
    if (zone54.westBound < mapState.center.longitude &&
        mapState.center.longitude < zone54.eastBound) {
      zone54.drawFrameByStandardPoints(canvas, mapState, size);
    }

    print("${mapState.center} ${mapState.zoom}");
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
    // throw UnimplementedError();
  }
}
