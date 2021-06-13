import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/plugin_api.dart';

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
    CustomPoint projected =
        mapState.project(LatLng(42.00, 132.00), mapState.zoom);

    final p = Paint();
    p.color = Colors.red;
    // canvas.drawLine(Offset(0, 0), Offset(100, 100), p);
    // canvas.drawLine(Offset(0, 0), Offset(size.width, size.height), p);
    // canvas.drawCircle(customPointToPixelPos(projected, mapState), 30, p);

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
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
    // throw UnimplementedError();
  }
}

Offset customPointToPixelPos(CustomPoint projected, MapState mapState) {
  double pixelPosX =
      projected.x - mapState.getPixelBounds(mapState.zoom).topLeft.x;
  double pixelPosY =
      projected.y - mapState.getPixelBounds(mapState.zoom).topLeft.y;
  return Offset(pixelPosX, pixelPosY);
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

final List<String> bandCharacters = [
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'J',
  'K',
  'L',
  'M',
  'N',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
];

class LatBand {
  // Lat 0 to 8 is band "N"
  String bandName;

  double southBound;
  double northBound;

  LatBand(String bandName) {
    this.bandName = bandName.toUpperCase();

    int i = bandCharacters.indexOf(this.bandName) + 1;
    if (i > 10) {
      // print(i);
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

    print(mapState.project(LatLng(this.southBound, 0.0), mapState.zoom).y);
    Offset pixelLeft = Offset(0.0, pixelPosSouth);
    Offset pixelRight = Offset(size.width, pixelPosSouth);
    canvas.drawLine(pixelLeft, pixelRight, p);
  }
}
