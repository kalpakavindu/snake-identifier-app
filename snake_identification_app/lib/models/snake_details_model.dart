import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import '../constants.dart';

class SnakeDetails {
  late String? length;
  late String? color;
  late File? image;
  late String? scalesPattern;
  late String? headPattern;
  late String? time;
  late String? location;
  final headers = <String, String>{
    'Accept': '*/*',
    'Content-Type': 'application/json; charset=UTF-8',
  };

  Future<Map<String, dynamic>> predictedData() async {
    if (image != null) {
      final uri = Uri.parse('$backendBaseUri/predictImage');
      final data = jsonEncode(<String, String>{"name": basename(image!.path)});

      final response = await http.post(uri, headers: headers, body: data);
      return {"status": response.statusCode, "body": jsonDecode(response.body)};
    }

    final uri = Uri.parse('$backendBaseUri/predictText');
    final data = jsonEncode(<String, String>{
      'snake_length': length!,
      'snake_color': color!,
      'snake_location': location!,
      'snake_scales_pattern': scalesPattern!,
      'snake_head_pattern': headPattern!,
      'snake_time': time!,
    });

    final response = await http.post(uri, headers: headers, body: data);
    return {"status": response.statusCode, "body": jsonDecode(response.body)};
  }
}
