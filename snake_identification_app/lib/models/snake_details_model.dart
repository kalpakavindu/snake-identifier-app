import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../constants.dart';

class SnakeDetails {
  late String? length;
  late String? color;
  late File? image;
  late String? scalesPattern;
  late String? headPattern;
  late String? time;
  late String? location;
  late String? fileName;
  late String? place;
  final _headers = <String, String>{
    'Accept': '*/*',
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Future<Map<String, dynamic>> predictedData() async {
    if (image != null) {
      final uri = Uri.parse('$backendBaseUri/predictImage');
      final data = jsonEncode(<String, String>{"name": fileName!});

      final response = await http.post(uri, headers: _headers, body: data);
      return {"status": response.statusCode, "body": response.body};
    }

    final uri = Uri.parse('$backendBaseUri/predictText');
    final data = jsonEncode(<String, String>{
      'length': length!,
      'color': color!,
      'location': location!,
      'scales_pattern': scalesPattern!,
      'head_pattern': headPattern!,
      'time': time!,
      'found_place': place!,
    });

    final response = await http.post(uri, headers: _headers, body: data);
    return {"status": response.statusCode, "body": response.body};
  }
}
