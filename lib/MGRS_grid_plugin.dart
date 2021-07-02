import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:grid_map/utm_zone.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/plugin_api.dart';

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
    zone52.draw(canvas, mapState, size);
    UtmZone zone53 = UtmZone(53);
    zone53.draw(canvas, mapState, size);
    UtmZone zone54 = UtmZone(54);
    zone54.draw(canvas, mapState, size);
    UtmZone zone55 = UtmZone(55);
    zone55.draw(canvas, mapState, size);

    LatBand bandR = LatBand('R');
    bandR.draw(canvas, mapState, size);
    LatBand bandS = LatBand('S');
    bandS.draw(canvas, mapState, size);
    LatBand bandT = LatBand('T');
    bandT.draw(canvas, mapState, size);
    LatBand bandU = LatBand('U');
    bandU.draw(canvas, mapState, size);

    zone53.standardPoints = pointsInZone53;
    zone53.drawFrameByStandardPoints(canvas, mapState, size);

    zone54.standardPoints = pointsInZone54;
    zone54.drawFrameByStandardPoints(canvas, mapState, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
    // throw UnimplementedError();
  }
}
