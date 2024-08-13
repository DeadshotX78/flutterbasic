import 'dart:convert';
import 'package:boredom/models/activity.dart';
import 'package:http/http.dart' as http;

class BoredApiService {
  static String baseUrl = 'https://bored-api.appbrewery.com';

  Future<Activity> fetchRandomActivity() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/random'));

      if (response.statusCode == 200) {
        return Activity.fromJson(
          json.decode(response.body),
        );
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      throw Exception('Failed to load');
    }
  }
}
