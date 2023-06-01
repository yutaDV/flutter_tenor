import 'package:flutter/material.dart';

class ImageScreen extends StatelessWidget {
  final String imageUrl;

  const ImageScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Screen Image'),
      ),
      body: Container(
        color: Colors.lightGreenAccent,
        child: Center(
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
