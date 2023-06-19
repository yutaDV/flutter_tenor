import 'package:dio/dio.dart';
import 'dart:convert';

class TenorAPI {
  static Dio _dio = Dio();

  static Future<List<String>> searchImages(String searchText) async {
    String apiKey = 'LIVDSRZULELA';
    String locale = 'en_US';
    int limit = 20; // Вказати потрібну кількість результатів

    String url = 'https://g.tenor.com/v1/search?key=$apiKey&q=$searchText&locale=$locale&limit=$limit';

    try {
      Response response = await _dio.get(url);
      if (response.statusCode == 200) {
        List<dynamic> results = response.data['results'];

        List<String> imageUrls = [];
        for (var result in results) {
          String imageUrl = result['media'][0]['gif']['url'];
          imageUrls.add(imageUrl);
        }

        return imageUrls;
      } else {
        print('Error: ${response.statusCode}');
        throw Exception('Failed to fetch image URLs');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch image URLs');
    }
  }

  static Future<List<String>> searchSuggestions(String searchText) async {
    String apiKey = 'LIVDSRZULELA';
    String locale = 'en_US';
    int limit = 20; // Вказати потрібну кількість результатів

    String url = 'https://g.tenor.com/v1/autocomplete?q=$searchText&key=$apiKey&locale=$locale&limit=$limit';

    try {
      Response response = await _dio.get(url);
      if (response.statusCode == 200) {
        List<dynamic> suggestions = response.data['results'];

        List<String> suggestionList = [];
        for (var suggestion in suggestions) {
          String suggestionText = suggestion['term'];
          suggestionList.add(suggestionText);
        }

        return suggestionList;
      } else {
        print('Error: ${response.statusCode}');
        throw Exception('Failed to fetch search suggestions');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to fetch search suggestions');
    }
  }
}
