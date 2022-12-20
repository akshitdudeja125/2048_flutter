import 'package:flutter/material.dart';
import 'package:flutter_2048/utils/colors.dart';

class ScoreCard extends StatelessWidget {
  final String label;
  final String score;
  const ScoreCard({
    Key? key,
    required this.label,
    required this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        color: scoreColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 18.0,
            color: textColor,
          ),
        ),
        Text(
          score,
          style: const TextStyle(
            color: textColorWhite,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        )
      ]),
    );
  }
}
