import 'package:flutter/material.dart';
import 'package:flutter_2048/providers.dart';
import 'package:flutter_2048/widgets/score_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScoreBoard extends ConsumerWidget {
  const ScoreBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final score = ref.watch(scoreProvider);
    final highScore = ref.watch(highScoreProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        ScoreCard(
          label: 'Score',
          score: score.toString(),
        ),
        const SizedBox(
          width: 6.0,
        ),
        ScoreCard(
          label: 'HIGH SCORE',
          score: highScore.toString(),
        )
      ],
    );
  }
}
