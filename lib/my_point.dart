import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';

class MyPoint {
  String point;

  Paint paint;

  MyPoint(String point) {
    this.point = point;
    this.paint = Paint();
    this.paint.color = Colors.red;
  }

  LatLng getLatLng() {
    double lon = jsonDecode(point)["geometry"]["coordinates"][0];
    double lat = jsonDecode(point)["geometry"]["coordinates"][1];
    return LatLng(lat, lon);
  }

  CustomPoint getCustomPoint(MapState mapState) {
    LatLng p = getLatLng();
    return mapState.project(p, mapState.zoom);
  }

  Offset getPixelPosition(MapState mapState) {
    CustomPoint projected = getCustomPoint(mapState);
    double pixelPosX =
        projected.x - mapState.getPixelBounds(mapState.zoom).topLeft.x;
    double pixelPosY =
        projected.y - mapState.getPixelBounds(mapState.zoom).topLeft.y;
    return Offset(pixelPosX, pixelPosY);
  }

  void draw(Canvas canvas, MapState mapState, Size size) {
    canvas.drawCircle(getPixelPosition(mapState), 3.0, paint);
  }
}
