import 'package:flutter/material.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({
    super.key,
    required this.title
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Hero(
          tag: 'hero1',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              "assets/images/practice_bg.jpeg", 
              color: Colors.teal, 
              colorBlendMode: BlendMode.color,
            )
          ),
        ),
        FittedBox(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50,
              letterSpacing: 20,
              wordSpacing: -20,
              color: Colors.teal[800]
            ),
          ),
        )
      ]
    );
  }
}