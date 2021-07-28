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
import 'grid_label.dart';

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
          painter: _MGRSGridPainter(options: options, mapState: mapState),
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

class _MGRSGridPainter extends CustomPainter {
  double w = 0.0;
  double h = 0.0;
  MGRSGridPluginOption options;
  MapState mapState;
  final Paint mPaint = Paint();

  _MGRSGridPainter({this.options, this.mapState});

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

    zone52.drawOuterFrameOfUtmZone(canvas, mapState);
    zone53.drawOuterFrameOfUtmZone(canvas, mapState);
    zone54.drawOuterFrameOfUtmZone(canvas, mapState);

    if (zone52.westBound < mapState.center.longitude &&
        mapState.center.longitude < zone52.eastBound) {
      zone52.draw100kmFramesWithAllStandardPoints(canvas, mapState, size);
    }

    if (zone53.westBound < mapState.center.longitude &&
        mapState.center.longitude < zone53.eastBound) {
      zone53.draw100kmFramesWithAllStandardPoints(canvas, mapState, size);

      int k = zone53.standardPoints.lastIndexWhere((element) =>
          element.first.getLongitude() < mapState.center.longitude);
      int l = zone53.standardPoints[0].lastIndexWhere(
          (element) => element.getLatitude() < mapState.center.latitude);

      // zone53.standardPoints[k][l].draw(canvas, mapState, size);
      MyPoint c = MyPoint.fromDouble(
          mapState.center.latitude, mapState.center.longitude);
      c.draw(canvas, mapState, size);

      // if (k > 0 && l > 0) {
      //   for (int i = 0; i < 3; i++) {
      //     for (int j = 0; j < 3; j++) {
      //       zone53.draw1kmGridIn100kmArea(
      //           canvas,
      //           mapState,
      //           zone53.standardPoints[k - 1 + i][l - 1 + j],
      //           zone53.standardPoints[k - 1 + i][l + j],
      //           zone53.standardPoints[k + i][l - 1 + j],
      //           zone53.standardPoints[k + i][l + j]);
      //     }
      //   }
      // }
      // else if (l < 0) {
      //   zone53.drawGeojsonSquareByStandardPoint(canvas, mapState, k, l + 1);
      //   zone53.drawGeojsonSquareByStandardPoint(canvas, mapState, k + 1, l + 1);
      // } else if (k < 0) {
      //   zone53.drawGeojsonSquareByStandardPoint(canvas, mapState, k + 1, l);
      //   zone53.drawGeojsonSquareByStandardPoint(canvas, mapState, k + 1, l + 1);
      // } else {
      //   print("$k,$l");
      // }
    }
    if (zone54.westBound < mapState.center.longitude &&
        mapState.center.longitude < zone54.eastBound) {
      zone54.draw100kmFramesWithAllStandardPoints(canvas, mapState, size);
    }

    print("${mapState.center} ${mapState.zoom}");

    const span = TextSpan(
      style: TextStyle(
        color: Colors.red,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      text: '00',
    );
    final textPainter = TextPainter(
      text: span,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
        canvas, zone53.standardPoints[1][1].getPixelPosition(mapState));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
    // throw UnimplementedError();
  }

  void drawText(Canvas canvas, double degree, int digits, double posx,
      double posy, bool isLat) {
    List<GridLabel> list = [];
    // canvasCall(canvas, list);
  }

  void canvasCall(Canvas canvas, Size size) {
    TextPainter p = TextPainter(
      text: TextSpan(text: "a"),
    );
    p.paint(canvas, Offset(size.width / 2.0, size.height / 2.0));
  }
}
