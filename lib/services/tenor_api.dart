import 'package:http/http.dart' as http;
import 'dart:convert';

class TenorAPI {
  static Future<List<String>> searchImages(String searchText) async {
    String apiKey = 'LIVDSRZULELA';
    String url = 'https://api.tenor.com/v1/search?key=$apiKey&q=$searchText&limit=20';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<dynamic> results = data['results'];

      List<String> imageUrls = [];
      for (var result in results) {
        String imageUrl = result['media'][0]['gif']['url'];
        imageUrls.add(imageUrl);
      }

      return imageUrls;
    } else {
      print('Error: ${response.statusCode}');
      return [];
    }
  }
}