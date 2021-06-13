import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/plugin_api.dart';

class MyMapPluginOption extends LayerOptions {}

class MyMapPlugin implements MapPlugin {
  /// MapPluginLatLonGridOptions
  final MyMapPluginOption options;

  /// Plugin options
  MyMapPlugin({this.options});

  @override
  Widget createLayer(
      LayerOptions options, MapState mapState, Stream<Null> stream) {
    // TODO: implement createLayer
    if (options is MyMapPluginOption) {
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
    // TODO: implement supportsLayer
    return options is MyMapPluginOption;
    throw UnimplementedError();
  }
}

class _MyPainter extends CustomPainter {
  double w = 0.0;
  double h = 0.0;
  MyMapPluginOption options;
  MapState mapState;
  final Paint mPaint = Paint();

  _MyPainter({this.options, this.mapState});

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    CustomPoint projected =
        mapState.project(LatLng(42.00, 132.00), mapState.zoom);

    final p = Paint();
    p.color = Colors.red;
    // canvas.drawLine(Offset(0, 0), Offset(100, 100), p);
    // canvas.drawLine(Offset(0, 0), Offset(size.width, size.height), p);
    canvas.drawCircle(customPointToPixelPos(projected, mapState), 30, p);

    UtmZone zone52 = UtmZone(52);
    zone52.draw(canvas, mapState, size);
    UtmZone zone53 = UtmZone(53);
    zone53.draw(canvas, mapState, size);
    UtmZone zone54 = UtmZone(54);
    zone54.draw(canvas, mapState, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
    throw UnimplementedError();
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

    drawLatLine(mapState, size, canvas, p);

    // canvas.drawLine(pixelTop,pixelBottom,  p);

    p.strokeWidth = 1.5;
  }

  void drawLatLine(MapState mapState, Size size, Canvas canvas, Paint p) {
    double pixelPosWest =
        mapState.project(LatLng(42.00, this.westBound), mapState.zoom).x -
            mapState.getPixelBounds(mapState.zoom).topLeft.x;
    Offset pixelTop = Offset(pixelPosWest, 0.0);
    Offset pixelBottom = Offset(pixelPosWest, size.height);
    canvas.drawLine(pixelTop, pixelBottom, p);
  }
}

class LatBand {
  final String bandName;

  LatBand({this.bandName});
}
