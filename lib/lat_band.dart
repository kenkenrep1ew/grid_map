import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';
import 'constant.dart';

class LatBand {
  // Lat 0 to 8 is band "N"
  String bandName;

  double southBound;
  double northBound;

  LatBand(String bandName) {
    this.bandName = bandName.toUpperCase();

    int i = bandCharacters.indexOf(this.bandName) + 1;
    if (i > 10) {
      this.southBound = (i - 11) * 8.0;
      // print(this.southBound);
      this.northBound = (i - 11) * 8.0 + 8;
      // print(this.northBound);
    }
  }

  void draw(Canvas canvas, MapState mapState, Size size) {
    Paint p = Paint();
    p.color = Colors.red;
    p.strokeWidth = 2.0;

    drawLatLine(mapState, size, canvas, p);
  }

  void drawLatLine(MapState mapState, Size size, Canvas canvas, Paint p) {
    double pixelPosSouth =
        mapState.project(LatLng(this.southBound, 0.0), mapState.zoom).y -
            mapState.getPixelBounds(mapState.zoom).topLeft.y;

    // print(mapState.project(LatLng(this.southBound, 0.0), mapState.zoom).y);
    Offset pixelLeft = Offset(0.0, pixelPosSouth);
    Offset pixelRight = Offset(size.width, pixelPosSouth);
    canvas.drawLine(pixelLeft, pixelRight, p);
  }
}
