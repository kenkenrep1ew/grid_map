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

    //For default;
    UtmZone nowInZone = zone53;

    zone52.drawOuterFrameOfUtmZone(canvas, mapState);
    zone53.drawOuterFrameOfUtmZone(canvas, mapState);
    zone54.drawOuterFrameOfUtmZone(canvas, mapState);

    if (zone52.westBound < mapState.center.longitude &&
        mapState.center.longitude < zone52.eastBound) {
      zone52.draw100kmFramesWithAllStandardPoints(canvas, mapState, size);
      nowInZone = zone52;
    }

    if (zone53.westBound < mapState.center.longitude &&
        mapState.center.longitude < zone53.eastBound) {
      zone53.draw100kmFramesWithAllStandardPoints(canvas, mapState, size);
      nowInZone = zone53;
    }
    if (zone54.westBound < mapState.center.longitude &&
        mapState.center.longitude < zone54.eastBound) {
      zone54.draw100kmFramesWithAllStandardPoints(canvas, mapState, size);
      nowInZone = zone54;
    }

    // print("${mapState.bounds.west}");
    final index_h = nowInZone.standardPoints
        .indexWhere((item) => mapState.bounds.west < item[0].getLongitude());
    final index_v = nowInZone.standardPoints[index_h]
        .indexWhere((item) => mapState.bounds.south < item.getLatitude());
    List<Offset> corners;

    final length_h = nowInZone.standardPoints.length;
    final length_v = nowInZone.standardPoints[0].length;
    if (9 < mapState.zoom) {
      if ((0 < index_h && index_h < length_h) &&
          (0 < index_v && index_v < length_v)) {
        if (nowInZone.standardPoints[index_h][0].getLongitude() <
            mapState.bounds.east) {
          if (nowInZone.standardPoints[index_h][index_v].getLatitude() <
              mapState.bounds.north) {
            print("4ko");
            corners = get4Corner(
                nowInZone.standardPoints, index_h + 1, index_v, mapState);
            drawGridAndLabel(corners, canvas, p, size,
                withHorizontalLabel: false);
            corners = get4Corner(
                nowInZone.standardPoints, index_h, index_v + 1, mapState);
            drawGridAndLabel(corners, canvas, p, size,
                withVerticalLabel: false);
            corners = get4Corner(
                nowInZone.standardPoints, index_h + 1, index_v + 1, mapState);
            drawGridAndLabel(corners, canvas, p, size,
                withVerticalLabel: false, withHorizontalLabel: false);
            corners = get4Corner(
                nowInZone.standardPoints, index_h, index_v, mapState);
            drawGridAndLabel(corners, canvas, p, size);
          } else {
            print("yoko2ko");
            corners = get4Corner(
                nowInZone.standardPoints, index_h + 1, index_v, mapState);
            drawGridAndLabel(corners, canvas, p, size,
                withHorizontalLabel: false);
            corners = get4Corner(
                nowInZone.standardPoints, index_h, index_v, mapState);
            drawGridAndLabel(corners, canvas, p, size);
          }
        } else {
          if (nowInZone.standardPoints[index_h][index_v].getLatitude() <
              mapState.bounds.north) {
            print("tate2ko");
            corners = get4Corner(
                nowInZone.standardPoints, index_h, index_v + 1, mapState);
            drawGridAndLabel(corners, canvas, p, size,
                withVerticalLabel: false);
            corners = get4Corner(
                nowInZone.standardPoints, index_h, index_v, mapState);
            drawGridAndLabel(corners, canvas, p, size);
          } else {
            print("1ko");
            corners = get4Corner(
                nowInZone.standardPoints, index_h, index_v, mapState);
            drawGridAndLabel(corners, canvas, p, size);
          }
        }
      }
    }
  }

  void drawGridAndLabel(List<Offset> corners, Canvas canvas, Paint p, Size size,
      {bool withVerticalLabel = true, bool withHorizontalLabel = true}) {
    if (9 < mapState.zoom && mapState.zoom <= 10) {
      drawLabelsForVkmGrid(10, corners, canvas, p, size,
          withVerticalLabel: withVerticalLabel,
          withHorizontalLabel: withHorizontalLabel);
    } else if (11 <= mapState.zoom && mapState.zoom < 12) {
      drawLabelsForVkmGrid(5, corners, canvas, p, size,
          withVerticalLabel: withVerticalLabel,
          withHorizontalLabel: withHorizontalLabel);
    } else if (12 <= mapState.zoom && mapState.zoom < 13) {
      drawLabelsForVkmGrid(2, corners, canvas, p, size,
          withVerticalLabel: withVerticalLabel,
          withHorizontalLabel: withHorizontalLabel);
    } else if (13 <= mapState.zoom) {
      drawLabelsForVkmGrid(1, corners, canvas, p, size,
          withVerticalLabel: withVerticalLabel,
          withHorizontalLabel: withHorizontalLabel);
    }
  }

  List<Offset> get4Corner(
      List<List<MyPoint>> sp, int index_h, int index_v, MapState mapState) {
    Offset bottomLeft = sp[index_h - 1][index_v - 1].getPixelPosition(mapState);
    Offset bottomRight = sp[index_h][index_v - 1].getPixelPosition(mapState);
    Offset topLeft = sp[index_h - 1][index_v].getPixelPosition(mapState);
    Offset topRight = sp[index_h][index_v].getPixelPosition(mapState);
    return [bottomLeft, bottomRight, topLeft, topRight];
  }

  void drawLabelsForVkmGrid(
      int gridSpace, List<Offset> corners, Canvas canvas, Paint p, Size size,
      {bool withVerticalLabel = true, bool withHorizontalLabel = true}) {
    Offset bottomLeft = corners[0];
    Offset bottomRight = corners[1];
    Offset topLeft = corners[2];
    Offset topRight = corners[3];
    double numberOfGrid = 100 / gridSpace;
    TextPainter textPainter = getLabelPainter("00");
    textPainter.layout();
    drawVerticalLabel(canvas, size, bottomLeft, topLeft, textPainter);
    drawHorizontalLabel(canvas, size, bottomLeft, bottomRight, textPainter);
    for (int i = 1; i < numberOfGrid; i++) {
      Offset bottom = Offset(
          (bottomLeft.dx + (bottomRight.dx - bottomLeft.dx) * i / numberOfGrid),
          (bottomLeft.dy +
              (bottomRight.dy - bottomLeft.dy) * i / numberOfGrid));

      Offset top = Offset(
          (topLeft.dx + (topRight.dx - topLeft.dx) * i / numberOfGrid),
          (topLeft.dy + (topRight.dy - topLeft.dy) * i / numberOfGrid));
      canvas.drawLine(top, bottom, p);

      Offset left = Offset(
          bottomLeft.dx - (bottomLeft.dx - topLeft.dx) * i / numberOfGrid,
          bottomLeft.dy - (bottomLeft.dy - topLeft.dy) * i / numberOfGrid);

      Offset right = Offset(
          bottomRight.dx - (bottomRight.dx - topRight.dx) * i / numberOfGrid,
          bottomRight.dy - (bottomRight.dy - topRight.dy) * i / numberOfGrid);
      canvas.drawLine(left, right, p);

      String label;
      switch (gridSpace) {
        case 10:
          label = i.toString() + "0";
          break;
        case 5:
          if (i * 5 < 10) {
            label = "0" + (i * 5).toString();
          } else {
            label = (i * 5).toString();
          }
          break;
        case 2:
          if (i * 2 < 10) {
            label = "0" + (i * 2).toString();
          } else {
            label = (i * 2).toString();
          }
          break;
        case 1:
          if (i < 10) {
            label = "0" + i.toString();
          } else {
            label = i.toString();
          }
          break;
        default:
          break;
      }

      TextPainter textPainter = getLabelPainter(label);
      textPainter.layout();
      if (withVerticalLabel) {
        drawVerticalLabel(canvas, size, top, bottom, textPainter);
      }
      if (withHorizontalLabel) {
        drawHorizontalLabel(canvas, size, left, right, textPainter);
      }
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
    labelPosY =
        (b.dy - a.dy) * (labelPosX - a.dx) / (b.dx - a.dx) + a.dy - 10.0;
    textPainter.paint(canvas, Offset(labelPosX, labelPosY));

    //Draw the Right label of horizontal grid
    labelPosX = size.width - 40.0;
    labelPosY =
        (b.dy - a.dy) * (labelPosX - a.dx) / (b.dx - a.dx) + a.dy - 10.0;
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
