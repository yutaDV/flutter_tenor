import 'package:flutter/material.dart';
import '/widgets/image_widget.dart';
import '/services/tenor_api.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchText = '';
  List<String> _imageUrls = [];

  void _searchImages() async {
    List<String> imageUrls = await TenorAPI.searchImages(_searchText);

    setState(() {
      _imageUrls = imageUrls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Введіть текст тут',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchImages();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: _imageUrls.length,
              itemBuilder: (context, index) {
                return ImageWidget(imageUrl: _imageUrls[index]);
              },
              shrinkWrap: true,
            ),
          ),
          Container(
            height: 60.0,
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    // Виконати дії при натисканні на кнопку "Головна"
                    // TODO: Додати код для обробки події натискання
                  },
                ),
                IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {
                    // Виконати дії при натисканні на кнопку "Улюблене"
                    // TODO: Додати код для обробки події натискання
                  },
                ),
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    // Виконати дії при натисканні на кнопку "Налаштування"
                    // TODO: Додати код для обробки події натискання
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
