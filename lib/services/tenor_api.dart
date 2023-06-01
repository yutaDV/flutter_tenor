import 'package:http/http.dart' as http;
import 'dart:convert';

class TenorAPI {
  static Future<List<String>> searchImages(String searchText) async {
    String apiKey = 'LIVDSRZULELA';
    String locale = 'en_US'; // Вказати потрібну локаль
    int limit = 20; // Вказати потрібну кількість результатів

    String url = 'https://g.tenor.com/v1/search?key=$apiKey&q=$searchText&locale=$locale&limit=$limit';

    var response = await http.get(Uri.parse(url));
    var responseBody = json.decode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      List<dynamic> results = responseBody['results'];

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
  }

  static Future<List<String>> searchSuggestions(String searchText) async {
    String apiKey = 'LIVDSRZULELA';
    String locale = 'en_US'; // Вказати потрібну локаль
    int limit = 20; // Вказати потрібну кількість результатів

    String url = 'https://g.tenor.com/v1/autocomplete?q=$searchText&key=$apiKey&locale=$locale&limit=$limit';

    var response = await http.get(Uri.parse(url));
    var responseBody = json.decode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      List<dynamic> suggestions = responseBody['results'];

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
  }
}
