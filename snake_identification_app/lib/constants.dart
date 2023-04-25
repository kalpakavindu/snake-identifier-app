import 'package:flutter/material.dart';

const String backendBaseUri = 'http://3.26.11.209:5000';
const String imageEndpoint = '/predictImage';
const String dataEndpoint = '/predictText';

final snakeLengthOptions = <Map<String, dynamic>>[
  {"child": const Text('below 0.5m'), "value": "below 0.5m"},
  {"child": const Text('0.5m - 1m'), "value": "0.5m - 1m"},
  {"child": const Text('1m - 1.5m'), "value": "1m - 1.5m"},
  {"child": const Text('1.5m - 2m'), "value": "1.5m - 2m"},
  {"child": const Text('2m - 2.5m'), "value": "2m - 2.5m"},
  {"child": const Text('2.5m - 3m'), "value": "2.5m - 3m"},
  {"child": const Text('3m - 3.5m'), "value": "3m - 3.5m"},
  {"child": const Text('above 3.5m'), "value": "above 3.5m"},
];

final snakeColorOptions = <Map<String, dynamic>>[
  {"child": const Text('Brown'), "value": "brown"},
  {"child": const Text('Green'), "value": "green"},
  {"child": const Text('Black'), "value": "black"},
  {"child": const Text('Yellow'), "value": "yellow"},
  {"child": const Text('Red'), "value": "red"},
];
final snakeLocationOptions = <Map<String, dynamic>>[
  {"child": const Text('Western Province'), "value": "western province"},
  {"child": const Text('Central Province'), "value": "central province"},
  {"child": const Text('Southern Province'), "value": "southern province"},
  {"child": const Text('Northern Province'), "value": "northern province"},
  {"child": const Text('Eastern Province'), "value": "eastern province"},
  {
    "child": const Text('North Western Province'),
    "value": "north western province"
  },
  {
    "child": const Text('North Central Province'),
    "value": "north central province"
  },
  {"child": const Text('Uva Province'), "value": "uva province"},
  {
    "child": const Text('Sabaragamuwa Province'),
    "value": "sabaragamuwa province"
  },
];
final snakeScalesPatternOptions = <Map<String, dynamic>>[
  {"child": const Text('Smooth'), "value": "smooth"},
  {"child": const Text('Kneeled'), "value": "kneeled"},
  {"child": const Text('Striped'), "value": "striped"},
  {"child": const Text('Banded'), "value": "banded"},
  {"child": const Text('Spotted'), "value": "spotted"},
];
final snakeHeadPatternOptions = <Map<String, dynamic>>[
  {"child": const Text('Spade-shaped'), "value": "spade-shaped"},
  {"child": const Text('Arrow-shaped'), "value": "arrow-shaped"},
  {"child": const Text('Heart-shaped'), "value": "heart-shaped"},
  {"child": const Text('Round'), "value": "round"},
  {"child": const Text('Rectangular'), "value": "rectangular"},
  {"child": const Text('Oval'), "value": "oval"},
  {"child": const Text('Triangular'), "value": "triangular"},
];
final snakeTimeOptions = <Map<String, dynamic>>[
  {"child": const Text('Morning'), "value": "morning"},
  {"child": const Text('Night'), "value": "night"},
];
final snakeFoundPlaceOptions = <Map<String, dynamic>>[
  {"child": const Text('Rocks and cliffs'), "value": "rocks and cliffs"},
  {"child": const Text('Residential areas'), "value": "residential areas"},
  {"child": const Text('Forests'), "value": "forests"},
  {"child": const Text('Wetlands'), "value": "wetlands"},
  {"child": const Text('Agricultural land'), "value": "agricultural land"},
];
