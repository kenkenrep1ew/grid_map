import 'package:flutter/material.dart';

class GridLabel {
  double degree;
  int digits;
  double posx;
  double posy;
  bool isLat;
  String label;
  TextPainter textPainter;

  GridLabel(this.degree, this.digits, this.posx, this.posy, this.isLat);
}
