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
}
