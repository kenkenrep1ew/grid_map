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

    TextPainter textPainter = getLabelPainter("00");
    textPainter.layout();

    Offset bottomLeft = zone53.standardPoints[1][1].getPixelPosition(mapState);
    zone53.standardPoints[1][1].draw(canvas, mapState, size);
    Offset topLeft = zone53.standardPoints[1][2].getPixelPosition(mapState);
    zone53.standardPoints[1][2].draw(canvas, mapState, size);

    drawVerticalLabel(canvas, size, bottomLeft, topLeft, textPainter);

    Offset bottomRight = zone53.standardPoints[2][1].getPixelPosition(mapState);
    zone53.standardPoints[2][1].draw(canvas, mapState, size);

    drawHorizontalLabel(canvas, size, bottomLeft, bottomRight, textPainter);

    Offset topRight = zone53.standardPoints[2][2].getPixelPosition(mapState);

    // drawLabelsFor1kmGrid(bottomLeft, bottomRight, topLeft, topRight, canvas, p, size);
  }

  void drawLabelsFor1kmGrid(Offset bottomLeft, Offset bottomRight,
      Offset topLeft, Offset topRight, Canvas canvas, Paint p, Size size) {
    for (int i = 1; i < 100; i++) {
      Offset bottom = Offset(
          (bottomLeft.dx + (bottomRight.dx - bottomLeft.dx) * i / 100),
          (bottomLeft.dy + (bottomRight.dy - bottomLeft.dy) * i / 100));

      Offset top = Offset((topLeft.dx + (topRight.dx - topLeft.dx) * i / 100),
          (topLeft.dy + (topRight.dy - topLeft.dy) * i / 100));
      canvas.drawLine(top, bottom, p);

      Offset left = Offset(
          bottomLeft.dx - (bottomLeft.dx - topLeft.dx) * i / 100,
          bottomLeft.dy - (bottomLeft.dy - topLeft.dy) * i / 100);

      Offset right = Offset(
          bottomRight.dx - (bottomRight.dx - topRight.dx) * i / 100,
          bottomRight.dy - (bottomRight.dy - topRight.dy) * i / 100);
      canvas.drawLine(left, right, p);

      String label;
      if (i < 10) {
        label = "0" + i.toString();
      } else {
        label = i.toString();
      }
      TextPainter textPainter = getLabelPainter(label);
      textPainter.layout();
      drawVerticalLabel(canvas, size, top, bottom, textPainter);
      drawHorizontalLabel(canvas, size, left, right, textPainter);
    }
  }

  TextPainter getLabelPainter(String s) {
    final textPainter = TextPainter(
      text: TextSpan(
        style: TextStyle(
          color: Colors.black54,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          // backgroundColor: Colors.black,
        ),
        text: s,
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    return textPainter;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
    // throw UnimplementedError();
  }

  void drawVerticalLabel(
      Canvas canvas, Size size, Offset a, Offset b, TextPainter textPainter) {
    //Draw the Upper label of vertical grid
    double labelPosY;
    double labelPosX;

    labelPosY = 40.0;
    labelPosX =
        (b.dx - a.dx) * (labelPosY - a.dy) / (b.dy - a.dy) + a.dx - 10.0;
    textPainter.paint(canvas, Offset(labelPosX, labelPosY));

    //Draw the Lower label of vertical grid
    labelPosY = size.height - 40.0;
    labelPosX =
        (b.dx - a.dx) * (labelPosY - a.dy) / (b.dy - a.dy) + a.dx - 10.0;
    textPainter.paint(canvas, Offset(labelPosX, labelPosY));
  }

  void drawHorizontalLabel(
      Canvas canvas, Size size, Offset a, Offset b, TextPainter textPainter) {
    double labelPosY;
    double labelPosX;

    //Draw the Left label of horizontal grid
    labelPosX = 20.0;
    labelPosY = (b.dy - a.dy) * (labelPosX - a.dx) / (b.dx - a.dx) + a.dy - 5.0;
    textPainter.paint(canvas, Offset(labelPosX, labelPosY));

    //Draw the Right label of horizontal grid
    labelPosX = size.width - 40.0;
    labelPosY = (b.dy - a.dy) * (labelPosX - a.dx) / (b.dx - a.dx) + a.dy - 5.0;
    textPainter.paint(canvas, Offset(labelPosX, labelPosY));
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
