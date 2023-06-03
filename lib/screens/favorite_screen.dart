import 'package:flutter/material.dart';
import '../services/sql_bd.dart';
import '../widgets/image_widget.dart';
import '../widgets/bottom_navigation_buttons.dart';
import 'home_screen.dart';
import 'search_screen.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<String> _imageUrls = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteImages();
  }

  void _loadFavoriteImages() async {
    List<String> imageUrls = await DatabaseHelper.getImageUrls();

    setState(() {
      _imageUrls = imageUrls;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: _imageUrls.length,
        itemBuilder: (context, index) {
          return ImageWidget(
            imageUrl: _imageUrls[index],
            isFavoriteScreen: true,
          );
        },
      ),
      bottomNavigationBar: BottomNavigationButtons(
        onHomePressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        },
        onFavoritePressed: () {
          // TODO: Handle favorite button pressed event
        },
        onSettingsPressed: () {
          // TODO: Handle Settings button pressed event
        },
      ),
    );
  }
}
