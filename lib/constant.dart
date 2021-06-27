import 'dart:convert';

import 'package:latlong/latlong.dart';

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
const PT_54SWB =
    '{"type":"Feature","id":"PT_54SWB0000","geometry":{"type":"Point","coordinates":[140.99999999999997,32.53735523621132,0]},"properties":{}}';
const PT_54SWC =
    '{"type":"Feature","id":"PT_54SWC0000","geometry":{"type":"Point","coordinates":[140.99999999999997,33.43939467250958,0]},"properties":{}}';
const PT_54SWD =
    '{"type":"Feature","id":"PT_54SWD0000","geometry":{"type":"Point","coordinates":[140.99999999999997,34.34130272267963,0]},"properties":{}}';
const PT_54SWE =
    '{"type":"Feature","id":"PT_54SWE0000","geometry":{"type":"Point","coordinates":[140.99999999999997,35.24307771200426,0]},"properties":{}}';
const PT_54SWF =
    '{"type":"Feature","id":"PT_54SWF0000","geometry":{"type":"Point","coordinates":[140.99999999999997,36.144718098817755,0]},"properties":{}}';
const PT_54SWG =
    '{"type":"Feature","id":"PT_54SWG0000","geometry":{"type":"Point","coordinates":[140.99999999999997,37.04622247590853,0]},"properties":{}}';
const PT_54SWH =
    '{"type":"Feature","id":"PT_54SWH0000","geometry":{"type":"Point","coordinates":[140.99999999999997,37.94758957178304,0]},"properties":{}}';
const PT_54SWJ =
    '{"type":"Feature","id":"PT_54SWJ0000","geometry":{"type":"Point","coordinates":[140.99999999999997,38.848818251789965,0]},"properties":{}}';
const PT_54SWK =
    '{"type":"Feature","id":"PT_54SWK0000","geometry":{"type":"Point","coordinates":[140.99999999999997,39.7499075191044,0]},"properties":{}}';
const PT_54TWL =
    '{"type":"Feature","id":"PT_54TWL0000","geometry":{"type":"Point","coordinates":[140.99999999999997,40.65085651557127,0]},"properties":{}}';
const PT_54TWM =
    '{"type":"Feature","id":"PT_54TWM0000","geometry":{"type":"Point","coordinates":[140.99999999999997,41.55166452240816,0]},"properties":{}}';
const PT_54TWN =
    '{"type":"Feature","id":"PT_54TWN0000","geometry":{"type":"Point","coordinates":[140.99999999999997,42.45233096076683,0]},"properties":{}}';
const PT_54TWP =
    '{"type":"Feature","id":"PT_54TWP0000","geometry":{"type":"Point","coordinates":[140.99999999999997,43.352855392154,0]},"properties":{}}';
const PT_54TWQ =
    '{"type":"Feature","id":"PT_54TWQ0000","geometry":{"type":"Point","coordinates":[140.99999999999997,44.25323751871147,0]},"properties":{}}';
const PT_54TWR =
    '{"type":"Feature","id":"PT_54TWR0000","geometry":{"type":"Point","coordinates":[140.99999999999997,45.15347718335561,0]},"properties":{}}';

const PT_54SVB =
    '{"type":"Feature","id":"PT_54SVB0000","geometry":{"type":"Point","coordinates":[139.93512013579462,32.53284662620779,0]},"properties":{}}';
const PT_54SVC =
    '{"type":"Feature","id":"PT_54SVC0000","geometry":{"type":"Point","coordinates":[139.92423596142197,33.43472882538433,0]},"properties":{}}';
const PT_54SVD =
    '{"type":"Feature","id":"PT_54SVD0000","geometry":{"type":"Point","coordinates":[139.9128561605185,34.33647641476016,0]},"properties":{}}';
const PT_54SVE =
    '{"type":"Feature","id":"PT_54SVE0000","geometry":{"type":"Point","coordinates":[139.90095918762847,35.23808753540773,0]},"properties":{}}';
const PT_54SVF =
    '{"type":"Feature","id":"PT_54SVF0000","geometry":{"type":"Point","coordinates":[139.88852196777378,36.139560449860255,0]},"properties":{}}';
const PT_54SVG =
    '{"type":"Feature","id":"PT_54SVG0000","geometry":{"type":"Point","coordinates":[139.87551977005998,37.04089354251013,0]},"properties":{}}';
const PT_54SVH =
    '{"type":"Feature","id":"PT_54SVH0000","geometry":{"type":"Point","coordinates":[139.8619260680683,37.942085319765845,0]},"properties":{}}';
const PT_54SVJ =
    '{"type":"Feature","id":"PT_54SVJ0000","geometry":{"type":"Point","coordinates":[139.84771238541816,38.84313440995389,0]},"properties":{}}';
const PT_54SVK =
    '{"type":"Feature","id":"PT_54SVK0000","geometry":{"type":"Point","coordinates":[139.8328481246542,39.74403956295087,0]},"properties":{}}';
const PT_54TVL =
    '{"type":"Feature","id":"PT_54TVL0000","geometry":{"type":"Point","coordinates":[139.8173003773432,40.64479964952847,0]},"properties":{}}';
const PT_54TVM =
    '{"type":"Feature","id":"PT_54TVM0000","geometry":{"type":"Point","coordinates":[139.80103371295195,41.54541366039244,0]},"properties":{}}';
const PT_54TVN =
    '{"type":"Feature","id":"PT_54TVN0000","geometry":{"type":"Point","coordinates":[139.78400994371162,42.44588070489298,0]},"properties":{}}';
const PT_54TVP =
    '{"type":"Feature","id":"PT_54TVP0000","geometry":{"type":"Point","coordinates":[139.76618786224313,43.34620000938183,0]},"properties":{}}';
const PT_54TVQ =
    '{"type":"Feature","id":"PT_54TVQ0000","geometry":{"type":"Point","coordinates":[139.7475229482127,44.24637091518704,0]},"properties":{}}';
const PT_54TVR =
    '{"type":"Feature","id":"PT_54TVR0000","geometry":{"type":"Point","coordinates":[139.72796703968976,45.14639287617132,0]},"properties":{}}';

const PT_54SUB =
    '{"type":"Feature","id":"PT_54SUB0000","geometry":{"type":"Point","coordinates":[138.870715549372,32.519327665049126,0]},"properties":{}}';
const PT_54SUC =
    '{"type":"Feature","id":"PT_54SUC0000","geometry":{"type":"Point","coordinates":[138.84896731384563,33.420738490322194,0]},"properties":{}}';
const PT_54SUD =
    '{"type":"Feature","id":"PT_54SUD0000","geometry":{"type":"Point","coordinates":[138.82622923842953,34.322005052192544,0]},"properties":{}}';
const PT_54SUE =
    '{"type":"Feature","id":"PT_54SUE0000","geometry":{"type":"Point","coordinates":[138.80245834660118,35.223124940555316,0]},"properties":{}}';
const PT_54SUF =
    '{"type":"Feature","id":"PT_54SUF0000","geometry":{"type":"Point","coordinates":[138.77760861456292,36.12409583213701,0]},"properties":{}}';
const PT_54SUG =
    '{"type":"Feature","id":"PT_54SUG0000","geometry":{"type":"Point","coordinates":[138.7516307198657,37.024915487898205,0]},"properties":{}}';
const PT_54SUH =
    '{"type":"Feature","id":"PT_54SUH0000","geometry":{"type":"Point","coordinates":[138.72447176380265,37.925581749889,0]},"properties":{}}';
const PT_54SUJ =
    '{"type":"Feature","id":"PT_54SUJ0000","geometry":{"type":"Point","coordinates":[138.6960749643743,38.82609253750627,0]},"properties":{}}';
const PT_54SUK =
    '{"type":"Feature","id":"PT_54SUK0000","geometry":{"type":"Point","coordinates":[138.66637931617004,39.72644584309502,0]},"properties":{}}';
const PT_54TUL =
    '{"type":"Feature","id":"PT_54TUL0000","geometry":{"type":"Point","coordinates":[138.63531921298122,40.6266397268271,0]},"properties":{}}';
const PT_54TUM =
    '{"type":"Feature","id":"PT_54TUM0000","geometry":{"type":"Point","coordinates":[138.6028240283417,41.52667231078217,0]},"properties":{}}';
const PT_54TUN =
    '{"type":"Feature","id":"PT_54TUN0000","geometry":{"type":"Point","coordinates":[138.56881764846912,42.42654177214336,0]},"properties":{}}';
const PT_54TUP =
    '{"type":"Feature","id":"PT_54TUP0000","geometry":{"type":"Point","coordinates":[138.5332179512315,43.326246335407994,0]},"properties":{}}';
const PT_54TUQ =
    '{"type":"Feature","id":"PT_54TUQ0000","geometry":{"type":"Point","coordinates":[138.49593622376807,44.22578426349774,0]},"properties":{}}';
const PT_54TUR =
    '{"type":"Feature","id":"PT_54TUR0000","geometry":{"type":"Point","coordinates":[138.4568765102173,45.12515384763386,0]},"properties":{}}';

const PT_54SXB =
    '{"type":"Feature","id":"PT_54SXB0000","geometry":{"type":"Point","coordinates":[142.06487986420535,32.53284662620779,0]},"properties":{}}';
const PT_54SXC =
    '{"type":"Feature","id":"PT_54SXC0000","geometry":{"type":"Point","coordinates":[142.075764038578,33.43472882538433,0]},"properties":{}}';
const PT_54SXD =
    '{"type":"Feature","id":"PT_54SXD0000","geometry":{"type":"Point","coordinates":[142.08714383948148,34.33647641476016,0]},"properties":{}}';
const PT_54SXE =
    '{"type":"Feature","id":"PT_54SXE0000","geometry":{"type":"Point","coordinates":[142.0990408123715,35.23808753540773,0]},"properties":{}}';
const PT_54SXF =
    '{"type":"Feature","id":"PT_54SXF0000","geometry":{"type":"Point","coordinates":[142.1114780322262,36.139560449860255,0]},"properties":{}}';
const PT_54SXG =
    '{"type":"Feature","id":"PT_54SXG0000","geometry":{"type":"Point","coordinates":[142.12448022993996,37.04089354251013,0]},"properties":{}}';
const PT_54SXH =
    '{"type":"Feature","id":"PT_54SXH0000","geometry":{"type":"Point","coordinates":[142.13807393193164,37.942085319765845,0]},"properties":{}}';
const PT_54SXJ =
    '{"type":"Feature","id":"PT_54SXJ0000","geometry":{"type":"Point","coordinates":[142.1522876145818,38.84313440995389,0]},"properties":{}}';
const PT_54SXK =
    '{"type":"Feature","id":"PT_54SXK0000","geometry":{"type":"Point","coordinates":[142.16715187534575,39.74403956295087,0]},"properties":{}}';
const PT_54TXL =
    '{"type":"Feature","id":"PT_54TXL0000","geometry":{"type":"Point","coordinates":[142.18269962265674,40.64479964952847,0]},"properties":{}}';
const PT_54TXM =
    '{"type":"Feature","id":"PT_54TXM0000","geometry":{"type":"Point","coordinates":[142.198966287048,41.54541366039244,0]},"properties":{}}';
const PT_54TXN =
    '{"type":"Feature","id":"PT_54TXN0000","geometry":{"type":"Point","coordinates":[142.21599005628835,42.44588070489298,0]},"properties":{}}';
const PT_54TXP =
    '{"type":"Feature","id":"PT_54TXP0000","geometry":{"type":"Point","coordinates":[142.23381213775684,43.34620000938183,0]},"properties":{}}';
const PT_54TXQ =
    '{"type":"Feature","id":"PT_54TXQ0000","geometry":{"type":"Point","coordinates":[142.25247705178728,44.24637091518704,0]},"properties":{}}';
const PT_54TXR =
    '{"type":"Feature","id":"PT_54TXR0000","geometry":{"type":"Point","coordinates":[142.2720329603102,45.14639287617132,0]},"properties":{}}';

const PT_54SYB =
    '{"type":"Feature","id":"PT_54SYB0000","geometry":{"type":"Point","coordinates":[143.12928445062798,32.519327665049126,0]},"properties":{}}';
const PT_54SYC =
    '{"type":"Feature","id":"PT_54SYC0000","geometry":{"type":"Point","coordinates":[143.15103268615434,33.420738490322194,0]},"properties":{}}';
const PT_54SYD =
    '{"type":"Feature","id":"PT_54SYD0000","geometry":{"type":"Point","coordinates":[143.17377076157044,34.322005052192544,0]},"properties":{}}';
const PT_54SYE =
    '{"type":"Feature","id":"PT_54SYE0000","geometry":{"type":"Point","coordinates":[143.1975416533988,35.223124940555316,0]},"properties":{}}';
const PT_54SYF =
    '{"type":"Feature","id":"PT_54SYF0000","geometry":{"type":"Point","coordinates":[143.22239138543702,36.12409583213701,0]},"properties":{}}';
const PT_54SYG =
    '{"type":"Feature","id":"PT_54SYG0000","geometry":{"type":"Point","coordinates":[143.24836928013428,37.024915487898205,0]},"properties":{}}';
const PT_54SYH =
    '{"type":"Feature","id":"PT_54SYH0000","geometry":{"type":"Point","coordinates":[143.2755282361973,37.925581749889,0]},"properties":{}}';
const PT_54SYJ =
    '{"type":"Feature","id":"PT_54SYJ0000","geometry":{"type":"Point","coordinates":[143.30392503562567,38.82609253750627,0]},"properties":{}}';
const PT_54SYK =
    '{"type":"Feature","id":"PT_54SYK0000","geometry":{"type":"Point","coordinates":[143.33362068382993,39.72644584309502,0]},"properties":{}}';
const PT_54TYL =
    '{"type":"Feature","id":"PT_54TYL0000","geometry":{"type":"Point","coordinates":[143.36468078701876,40.6266397268271,0]},"properties":{}}';
const PT_54TYM =
    '{"type":"Feature","id":"PT_54TYM0000","geometry":{"type":"Point","coordinates":[143.39717597165827,41.52667231078217,0]},"properties":{}}';
const PT_54TYN =
    '{"type":"Feature","id":"PT_54TYN0000","geometry":{"type":"Point","coordinates":[143.43118235153082,42.42654177214336,0]},"properties":{}}';
const PT_54TYP =
    '{"type":"Feature","id":"PT_54TYP0000","geometry":{"type":"Point","coordinates":[143.46678204876847,43.326246335407994,0]},"properties":{}}';
const PT_54TYQ =
    '{"type":"Feature","id":"PT_54TYQ0000","geometry":{"type":"Point","coordinates":[143.5040637762319,44.22578426349774,0]},"properties":{}}';
const PT_54TYR =
    '{"type":"Feature","id":"PT_54TYR0000","geometry":{"type":"Point","coordinates":[143.54312348978266,45.12515384763386,0]},"properties":{}}';

const PT_54STG =
    '{"type":"Feature","id":"PT_54STG0000","geometry":{"type":"Point","coordinates":[137.62892208473906,36.99831450836676,0]},"properties":{}}';
