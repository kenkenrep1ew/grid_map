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
  Paint p;

  List<List<MyPoint>> standardPoints;

  List<LatBand> latBands;

  UtmZone(int zoneNumber) {
    this.zoneNumber = zoneNumber;
    if (30 < zoneNumber) {
      this.westBound = (this.zoneNumber - 30) * 6.0 - 6;
      this.centerLine = (this.zoneNumber - 30) * 6.0 - 3;
      this.eastBound = (this.zoneNumber - 30) * 6.0;
    }
    this.p = Paint();
    this.p.color = Colors.red;
  }

  void draw(Canvas canvas, MapState mapState, Size size) {
    p.strokeWidth = 2.0;

    drawLonLine(canvas, mapState, size);

    p.strokeWidth = 0.5;

    drawCenterLine(canvas, mapState, size);
  }

  void drawLonLine(Canvas canvas, MapState mapState, Size size) {
    p.strokeWidth = 2.0;
    double pixelPosWest =
        mapState.project(LatLng(42.00, this.westBound), mapState.zoom).x -
            mapState.getPixelBounds(mapState.zoom).topLeft.x;
    Offset pixelTop = Offset(pixelPosWest, 0.0);
    Offset pixelBottom = Offset(pixelPosWest, size.height);
    canvas.drawLine(pixelTop, pixelBottom, p);
  }

  void drawCenterLine(Canvas canvas, MapState mapState, Size size) {
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
        // standardPoints[i][j].draw(canvas, mapState, size);
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
    p.strokeWidth = 0.5;
    canvas.drawLine(startPoint.getPixelPosition(mapState),
        endPoint.getPixelPosition(mapState), p);
  }

  //
  void drawGeojsonSquare(Canvas canvas, MapState mapState, MyPoint bottomLeft,
      MyPoint bottomRight, MyPoint topLeft, MyPoint topRight) {
    p.strokeWidth = 0.5;
    //
    if (5.0 < mapState.zoom) {
      drawGeojsonLine(canvas, mapState, bottomLeft, bottomRight);
      drawGeojsonLine(canvas, mapState, bottomLeft, topLeft);
      drawGeojsonLine(canvas, mapState, topLeft, topRight);
      drawGeojsonLine(canvas, mapState, bottomRight, topRight);
      if (8.0 < mapState.zoom) {
        for (int i = 1; i < 10; i++) {
          Offset bottom = Offset(
              (bottomLeft.getPixelPosition(mapState).dx +
                  (bottomRight.getPixelPosition(mapState).dx -
                          bottomLeft.getPixelPosition(mapState).dx) *
                      i /
                      10),
              (bottomLeft.getPixelPosition(mapState).dy +
                  (bottomRight.getPixelPosition(mapState).dy -
                          bottomLeft.getPixelPosition(mapState).dy) *
                      i /
                      10));
          // canvas.drawCircle(bottom, 3.0, p);

          Offset top = Offset(
              (topLeft.getPixelPosition(mapState).dx +
                  (topRight.getPixelPosition(mapState).dx -
                          topLeft.getPixelPosition(mapState).dx) *
                      i /
                      10),
              (topLeft.getPixelPosition(mapState).dy +
                  (topRight.getPixelPosition(mapState).dy -
                          topLeft.getPixelPosition(mapState).dy) *
                      i /
                      10));
          // canvas.drawCircle(top, 3.0, p);
          canvas.drawLine(top, bottom, p);

          Offset left = Offset(
              topLeft.getPixelPosition(mapState).dx +
                  (bottomLeft.getPixelPosition(mapState).dx -
                          topLeft.getPixelPosition(mapState).dx) *
                      i /
                      10,
              topLeft.getPixelPosition(mapState).dy +
                  (bottomLeft.getPixelPosition(mapState).dy -
                          topLeft.getPixelPosition(mapState).dy) *
                      i /
                      10);
          // canvas.drawCircle(left, 3.0, p);

          Offset right = Offset(
              topRight.getPixelPosition(mapState).dx +
                  (bottomRight.getPixelPosition(mapState).dx -
                          topRight.getPixelPosition(mapState).dx) *
                      i /
                      10,
              topRight.getPixelPosition(mapState).dy +
                  (bottomRight.getPixelPosition(mapState).dy -
                          topRight.getPixelPosition(mapState).dy) *
                      i /
                      10);
          // canvas.drawCircle(right, 3.0, p);
          canvas.drawLine(left, right, p);
        }
      }
    }
  }
}
