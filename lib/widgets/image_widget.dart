import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '/screens/image_screen.dart';
import '/services/sql_bd.dart';

class ImageWidget extends StatefulWidget {
  final String imageUrl;
  final bool isFavoriteScreen;

  const ImageWidget({
    Key? key,
    required this.imageUrl,
    this.isFavoriteScreen = false,
  }) : super(key: key);

  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  bool isFavorite = false;

  Future<void> addToFavorites() async {
    bool databaseExists = await DatabaseHelper.databaseExists();

    if (!databaseExists) {
      await DatabaseHelper.createDatabase();
    }

    await DatabaseHelper.addImageUrl(widget.imageUrl);
    setState(() {
      isFavorite = true;
    });
  }

  Future<void> removeFromFavorites() async {
    bool databaseExists = await DatabaseHelper.databaseExists();

    if (databaseExists) {
      await DatabaseHelper.removeImageUrl(widget.imageUrl);
      setState(() {
        isFavorite = false;
      });
    }
  }

  void _deleteImage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Image'),
          content: Text('Are you sure you want to delete this image?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                removeFromFavorites();
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageScreen(imageUrl: widget.imageUrl),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.lightGreen,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.lightGreenAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {
                        Share.share(widget.imageUrl);
                      },
                    ),
                    if (widget.isFavoriteScreen)
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          _deleteImage();
                        },
                      ),
                    if (!widget.isFavoriteScreen)
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.star : Icons.star_border,
                          color: isFavorite ? Colors.yellow : null,
                        ),
                        onPressed: () {
                          addToFavorites();
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
