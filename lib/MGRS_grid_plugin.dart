import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/plugin_api.dart';

import 'constant.dart';

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

    List<List<MyPoint>> myPoints = [
      [
        MyPoint(PT_54SUB),
        MyPoint(PT_54SUC),
        MyPoint(PT_54SUD),
        MyPoint(PT_54SUE),
        MyPoint(PT_54SUF),
        MyPoint(PT_54SUG),
        MyPoint(PT_54SUH),
        MyPoint(PT_54SUJ),
        MyPoint(PT_54SUK),
        MyPoint(PT_54TUL),
        MyPoint(PT_54TUM),
        MyPoint(PT_54TUN),
        MyPoint(PT_54TUP),
        MyPoint(PT_54TUQ),
        MyPoint(PT_54TUR)
      ],
      [
        MyPoint(PT_54SVB),
        MyPoint(PT_54SVC),
        MyPoint(PT_54SVD),
        MyPoint(PT_54SVE),
        MyPoint(PT_54SVF),
        MyPoint(PT_54SVG),
        MyPoint(PT_54SVH),
        MyPoint(PT_54SVJ),
        MyPoint(PT_54SVK),
        MyPoint(PT_54TVL),
        MyPoint(PT_54TVM),
        MyPoint(PT_54TVN),
        MyPoint(PT_54TVP),
        MyPoint(PT_54TVQ),
        MyPoint(PT_54TVR)
      ],
      [
        MyPoint(PT_54SWB),
        MyPoint(PT_54SWC),
        MyPoint(PT_54SWD),
        MyPoint(PT_54SWE),
        MyPoint(PT_54SWF),
        MyPoint(PT_54SWG),
        MyPoint(PT_54SWH),
        MyPoint(PT_54SWJ),
        MyPoint(PT_54SWK),
        MyPoint(PT_54TWL),
        MyPoint(PT_54TWM),
        MyPoint(PT_54TWN),
        MyPoint(PT_54TWP),
        MyPoint(PT_54TWQ),
        MyPoint(PT_54TWR)
      ],
      [
        MyPoint(PT_54SXB),
        MyPoint(PT_54SXC),
        MyPoint(PT_54SXD),
        MyPoint(PT_54SXE),
        MyPoint(PT_54SXF),
        MyPoint(PT_54SXG),
        MyPoint(PT_54SXH),
        MyPoint(PT_54SXJ),
        MyPoint(PT_54SXK),
        MyPoint(PT_54TXL),
        MyPoint(PT_54TXM),
        MyPoint(PT_54TXN),
        MyPoint(PT_54TXP),
        MyPoint(PT_54TXQ),
        MyPoint(PT_54TXR)
      ],
      [
        MyPoint(PT_54SYB),
        MyPoint(PT_54SYC),
        MyPoint(PT_54SYD),
        MyPoint(PT_54SYE),
        MyPoint(PT_54SYF),
        MyPoint(PT_54SYG),
        MyPoint(PT_54SYH),
        MyPoint(PT_54SYJ),
        MyPoint(PT_54SYK),
        MyPoint(PT_54TYL),
        MyPoint(PT_54TYM),
        MyPoint(PT_54TYN),
        MyPoint(PT_54TYP),
        MyPoint(PT_54TYQ),
        MyPoint(PT_54TYR)
      ],
    ];

    for (int i = 0; i < myPoints.length - 1; i++) {
      for (int j = 0; j < myPoints[i].length - 1; j++) {
        myPoints[i][j].draw(canvas, mapState, size);
        drawGeojsonSquare(canvas, mapState, myPoints[i][j], myPoints[i + 1][j],
            myPoints[i][j + 1], myPoints[i + 1][j + 1]);
      }
    }

    MyPoint(PT_54STG).draw(canvas, mapState, size);
    drawGeojsonLine(canvas, mapState, MyPoint(PT_54TYP), MyPoint(PT_54TYQ));
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
    drawGeojsonLine(canvas, mapState, bottomLeft, bottomRight);
    drawGeojsonLine(canvas, mapState, bottomLeft, topLeft);
    drawGeojsonLine(canvas, mapState, topLeft, topRight);
    drawGeojsonLine(canvas, mapState, bottomRight, topRight);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
    // throw UnimplementedError();
  }
}

class MyPoint {
  String point;

  MyPoint(String point) {
    this.point = point;
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
    Paint p = Paint();
    p.color = Colors.red;
    canvas.drawCircle(getPixelPosition(mapState), 3.0, p);
  }
}

class UtmZone {
  int zoneNumber;

  double westBound;
  double eastBound;
  double centerLine;

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

    drawLonLine(mapState, size, canvas, p);

    p.strokeWidth = 0.5;

    drawCenterLine(mapState, size, canvas, p);
  }

  void drawLonLine(MapState mapState, Size size, Canvas canvas, Paint p) {
    double pixelPosWest =
        mapState.project(LatLng(42.00, this.westBound), mapState.zoom).x -
            mapState.getPixelBounds(mapState.zoom).topLeft.x;
    Offset pixelTop = Offset(pixelPosWest, 0.0);
    Offset pixelBottom = Offset(pixelPosWest, size.height);
    canvas.drawLine(pixelTop, pixelBottom, p);
  }

  void drawCenterLine(MapState mapState, Size size, Canvas canvas, Paint p) {
    double pixelPosCenter =
        mapState.project(LatLng(42.00, this.centerLine), mapState.zoom).x -
            mapState.getPixelBounds(mapState.zoom).topLeft.x;
    Offset pixelTop = Offset(pixelPosCenter, 0.0);
    Offset pixelBottom = Offset(pixelPosCenter, size.height);
    canvas.drawLine(pixelTop, pixelBottom, p);
  }
}

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
