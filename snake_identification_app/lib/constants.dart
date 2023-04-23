const String backendBaseUri = 'http://3.26.115.100:5000';
const String imageEndpoint = '/predictImage';
const String dataEndpoint = '/predictText';

final List<Map<String, String>> snakeLengthOptions = [
  {"name": "Short", "value": "short"},
  {"name": "Long", "value": "long"},
];

final List<Map<String, String>> snakeColorOptions = [
  {"name": "Red", "value": "red"},
  {"name": "Green", "value": "green"},
  {"name": "Black", "value": "black"},
  {"name": "White", "value": "white"},
  {"name": "Yellow", "value": "yellow"},
  {"name": "Brown", "value": "brown"},
];
final List<Map<String, String>> snakeLocationOptions = [
  {"name": "Floor", "value": "floor"},
  {"name": "Mud", "value": "mud"},
  {"name": "Tree", "value": "tree"},
  {"name": "Other", "value": "other"},
];
final List<Map<String, String>> snakeScalesPatternOptions = [
  {"name": "SPattern1", "value": "sp1"},
  {"name": "SPattern2", "value": "sp2"},
  {"name": "SPattern3", "value": "sp3"},
];
final List<Map<String, String>> snakeHeadPatternOptions = [
  {"name": "HPattern1", "value": "hp1"},
  {"name": "HPattern2", "value": "hp2"},
  {"name": "HPattern3", "value": "hp3"},
];
final List<Map<String, String>> snakeTimeOptions = [
  {"name": "Morning", "value": "morning"},
  {"name": "Afternoon", "value": "afternoon"},
  {"name": "Evening", "value": "evening"},
  {"name": "Night", "value": "night"},
];
