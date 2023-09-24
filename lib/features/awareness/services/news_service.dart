import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchNewsArticles() async {
  final String apiKey = '127d6285e12a484986fd61e23d74ef19';
  final String query = 'water+footprint+India';
  final String url =
      'https://newsapi.org/v2/everything?q=$query&apiKey=$apiKey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    Map<String, dynamic> result = json.decode(response.body);
    return List<Map<String, dynamic>>.from(result['articles']);
  } else {
    throw Exception('Failed to load news articles');
  }
}
