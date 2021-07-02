import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';
import 'lat_band.dart';
import 'my_point.dart';

class UtmZone {
  int zoneNumber;

  double westBound;
  double eastBound;
  double centerLine;

  List<List<MyPoint>> standardPoints;

  List<LatBand> latBands;

  UtmZone(int zoneNumber) {
    this.zoneNumber = zoneNumber;
    if (30 < zoneNumber) {
      this.westBound = (this.zoneNumber - 30) * 6.0 - 6;
      this.centerLine = (this.zoneNumber - 30) * 6.0 - 3;
      this.eastBound = (this.zoneNumber - 30) * 6.0;
    }
  }

  void draw(Canvas canvas, MapState mapState, Size size) {
    Paint p = Paint();
    p.color = Colors.red;
    p.strokeWidth = 2.0;

    drawLonLine(canvas, mapState, size);

    p.strokeWidth = 0.5;

    drawCenterLine(canvas, mapState, size);
  }

  void drawLonLine(Canvas canvas, MapState mapState, Size size) {
    Paint p = Paint();
    p.color = Colors.red;
    p.strokeWidth = 2.0;
    double pixelPosWest =
        mapState.project(LatLng(42.00, this.westBound), mapState.zoom).x -
            mapState.getPixelBounds(mapState.zoom).topLeft.x;
    Offset pixelTop = Offset(pixelPosWest, 0.0);
    Offset pixelBottom = Offset(pixelPosWest, size.height);
    canvas.drawLine(pixelTop, pixelBottom, p);
  }

  void drawCenterLine(Canvas canvas, MapState mapState, Size size) {
    Paint p = Paint();
    p.color = Colors.red;
    p.strokeWidth = 0.5;
    double pixelPosCenter =
        mapState.project(LatLng(42.00, this.centerLine), mapState.zoom).x -
            mapState.getPixelBounds(mapState.zoom).topLeft.x;
    Offset pixelTop = Offset(pixelPosCenter, 0.0);
    Offset pixelBottom = Offset(pixelPosCenter, size.height);
    canvas.drawLine(pixelTop, pixelBottom, p);
  }

  void drawFrameByStandardPoints(Canvas canvas, MapState mapState, Size size) {
    for (int i = 0; i < standardPoints.length - 1; i++) {
      for (int j = 0; j < standardPoints[i].length - 1; j++) {
        standardPoints[i][j].draw(canvas, mapState, size);
        drawGeojsonSquare(
            canvas,
            mapState,
            standardPoints[i][j],
            standardPoints[i + 1][j],
            standardPoints[i][j + 1],
            standardPoints[i + 1][j + 1]);
      }
    }
  }

  void drawGeojsonLine(
      Canvas canvas, MapState mapState, MyPoint startPoint, MyPoint endPoint) {
    Paint p = Paint();
    p.color = Colors.red;

    canvas.drawLine(startPoint.getPixelPosition(mapState),
        endPoint.getPixelPosition(mapState), p);

    // print("p1:$p1 p2:$p2");
    // Offset center = Offset((p1.dx + p2.dx) / 2, (p1.dy + p2.dy) / 2);
    // print(center);
    // canvas.drawCircle(center, 3.0, paint);
  }

  //
  void drawGeojsonSquare(Canvas canvas, MapState mapState, MyPoint bottomLeft,
      MyPoint topLeft, MyPoint bottomRight, MyPoint topRight) {
    // Paint p = Paint();
    // p.color = Colors.red;
    // p.strokeWidth = 0.5;
    //
    drawGeojsonLine(canvas, mapState, bottomLeft, bottomRight);
    drawGeojsonLine(canvas, mapState, bottomLeft, bottomRight);
    drawGeojsonLine(canvas, mapState, bottomLeft, topLeft);
    drawGeojsonLine(canvas, mapState, topLeft, topRight);
    drawGeojsonLine(canvas, mapState, bottomRight, topRight);
  }
}
