import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_2048/controls.dart';
import 'package:flutter_2048/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameOverScreen extends ConsumerStatefulWidget {
  const GameOverScreen({super.key});

  @override
  ConsumerState<GameOverScreen> createState() => _GameOverScreenState();
}

class _GameOverScreenState extends ConsumerState<GameOverScreen> {
  Key key = UniqueKey();

  void restart() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Over'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Game Over',
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                restart();
                resetGrid(ref);
              },
              child: const Text('Restart'),
            ),
          ],
        ),
      ),
    );
  }
}

resetGrid(WidgetRef ref) {
  ref.watch(listProvider.notifier).state = generateNewGrid();
  ref.watch(highScoreProvider.notifier).state =
      max(ref.watch(highScoreProvider), ref.watch(scoreProvider));
  ref.watch(scoreProvider.notifier).state = 0;
  ref.watch(gameOverProvider.notifier).state = false;
  ref.watch(gameWonProvider.notifier).state = false;
}
