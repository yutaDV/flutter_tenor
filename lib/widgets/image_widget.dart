import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;

  const ImageWidget({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightGreen,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Виконати дії при натисканні на GIF
                // TODO: Додати код для переходу на наступний екран
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.star),
                  color: Colors.white,
                  onPressed: () {
                    // Виконати дії при натисканні на зірку
                    // TODO: Додати код для обробки події натискання
                  },
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  color: Colors.white,
                  onPressed: () {
                    // Виконати дії при натисканні на кнопку "Поділитись"
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
