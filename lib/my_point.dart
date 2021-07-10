import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong/latlong.dart';

class MyPoint {
  double _lon;
  double _lat;

  Paint paint = Paint();

  MyPoint(String point) {
    this._lon = jsonDecode(point)["geometry"]["coordinates"][0];
    this._lat = jsonDecode(point)["geometry"]["coordinates"][1];
  }

  MyPoint.fromDouble(double latitude, double longitude) {
    this._lat = latitude;
    this._lon = longitude;
  }

  double getLatitude() {
    return _lat;
  }

  double getLongitude() {
    return _lon;
  }

  LatLng getLatLng() {
    return LatLng(_lat, _lon);
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
