import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 400,
          width: 400,
          child: Lottie.asset('assets/lottie_images/parrot.json'),
        ),
        SizedBox(height: 40),

      ],
    );
  }
}
