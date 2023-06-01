import 'package:flutter/material.dart';

class BottomNavigationButtons extends StatelessWidget {
  final VoidCallback onHomePressed;
  final VoidCallback onFavoritePressed;
  final VoidCallback onSettingsPressed;

  const BottomNavigationButtons({
    required this.onHomePressed,
    required this.onFavoritePressed,
    required this.onSettingsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: onHomePressed,
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: onFavoritePressed,
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: onSettingsPressed,
          ),
        ],
      ),
    );
  }
}
