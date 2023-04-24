import 'package:flutter/material.dart';

const String backendBaseUri = 'http://3.27.150.156:5000';
const String imageEndpoint = '/predictImage';
const String dataEndpoint = '/predictText';

final snakeLengthOptions = <Map<String, dynamic>>[
  {"child": const Text('Short'), "value": "short"},
  {"child": const Text('Long'), "value": "long"},
];

final snakeColorOptions = <Map<String, dynamic>>[
  {"child": const Text('Red'), "value": "red"},
  {"child": const Text('Green'), "value": "green"},
  {"child": const Text('Black'), "value": "black"},
  {"child": const Text('White'), "value": "white"},
  {"child": const Text('Yellow'), "value": "yellow"},
  {"child": const Text('Brown'), "value": "brown"},
];
final snakeLocationOptions = <Map<String, dynamic>>[
  {"child": const Text('Floor'), "value": "floor"},
  {"child": const Text('Mud'), "value": "mud"},
  {"child": const Text('Tree'), "value": "tree"},
  {"child": const Text('Other'), "value": "other"},
];
final snakeScalesPatternOptions = <Map<String, dynamic>>[
  {
    "child": const SizedBox(
      width: 250.0,
      height: 30.0,
      child: Image(
        image: AssetImage(
          'assets/images/abstract_snake_purple_landing_screen.png',
        ),
        fit: BoxFit.fill,
      ),
    ),
    "value": "sp1"
  },
  {
    "child": const SizedBox(
      width: 250.0,
      height: 30.0,
      child: Image(
        image: AssetImage(
          'assets/images/abstract_snake_purple_landing_screen.png',
        ),
        fit: BoxFit.fill,
      ),
    ),
    "value": "sp2"
  },
  {
    "child": const SizedBox(
      width: 250.0,
      height: 30.0,
      child: Image(
        image: AssetImage(
          'assets/images/abstract_snake_purple_landing_screen.png',
        ),
        fit: BoxFit.fill,
      ),
    ),
    "value": "sp3"
  },
];
final snakeHeadPatternOptions = <Map<String, dynamic>>[
  {
    "child": const SizedBox(
      width: 250.0,
      height: 30.0,
      child: Image(
        image: AssetImage(
          'assets/images/abstract_snake_purple_landing_screen.png',
        ),
        fit: BoxFit.fill,
      ),
    ),
    "value": "hp1"
  },
  {
    "child": const SizedBox(
      width: 250.0,
      height: 30.0,
      child: Image(
        image: AssetImage(
          'assets/images/abstract_snake_purple_landing_screen.png',
        ),
        fit: BoxFit.fill,
      ),
    ),
    "value": "hp2"
  },
  {
    "child": const SizedBox(
      width: 250.0,
      height: 30.0,
      child: Image(
        image: AssetImage(
          'assets/images/abstract_snake_purple_landing_screen.png',
        ),
        fit: BoxFit.fill,
      ),
    ),
    "value": "hp3"
  },
];
final snakeTimeOptions = <Map<String, dynamic>>[
  {"child": const Text('Morning'), "value": "morning"},
  {"child": const Text('Afternoon'), "value": "afternoon"},
  {"child": const Text('Evening'), "value": "evening"},
  {"child": const Text('Night'), "value": "night"},
];
