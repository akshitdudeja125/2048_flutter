import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_2048/controls.dart';
import 'package:flutter_2048/providers.dart';
import 'package:flutter_2048/screens/game_over_screen.dart';
import 'package:flutter_2048/utils/generate_board.dart';
import 'package:flutter_2048/widgets/custom_button.dart';
import 'package:flutter_2048/widgets/score_board.dart';
import 'package:flutter_2048/utils/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:screenshot/screenshot.dart';
import 'package:tuple/tuple.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  ScreenshotController screenshotController = ScreenshotController();
  Key key = UniqueKey();

  void restart() {
    setState(() {
      key = UniqueKey();
      ref.read(scoreProvider.notifier).state = 0;
      resetGrid(ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<List<int>> grid = ref.watch(listProvider);
    final List<List<int>> previousGrid = ref.watch(previousListProvider);
    final score = ref.watch(scoreProvider);
    final previousScore = ref.watch(previousScoreProvider);
    final highScore = ref.watch(highScoreProvider);
    final gameOver = ref.watch(gameOverProvider);
    final gameWon = ref.watch(gameWonProvider);
    late Tuple5<int, int, int, List<List<int>>, List<List<int>>> result;

    if (gameOver) {
      return const GameOverScreen();
    } else if (gameWon) {
      return AlertDialog(
        title: const Center(
          child: Text(
            'You Won!',
            style: TextStyle(
                fontSize: 30,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.bold),
          ),
        ),
        // content: Text('Score:$score'),
        content: const SizedBox(
          // width: 200,
          height: 70,
          child: ScoreBoard(),
        ),
        actions: [
          Center(
            child: CustomButton(
              onPressed: restart,
              icon: const Icon(Icons.restart_alt),
            ),
          ),
        ],
      );
    } else {
      return GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity! < 0) {
            result = moveLeftAndMerge(
                score, highScore, previousScore, grid, previousGrid);
          } else if (details.primaryVelocity! > 0) {
            result = moveRightAndMerge(
                score, highScore, previousScore, grid, previousGrid);
          } else {
            result =
                Tuple5(score, highScore, previousScore, grid, previousGrid);
          }
          changeStates(ref, result, grid);
        },
        onVerticalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity! < 0) {
            result = moveUpAndMerge(
                score, highScore, previousScore, grid, previousGrid);
          } else if (details.primaryVelocity! > 0) {
            result = moveDownAndMerge(
                score, highScore, previousScore, grid, previousGrid);
          } else {
            result =
                Tuple5(score, highScore, previousScore, grid, previousGrid);
          }
          changeStates(ref, result, grid);
        },
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '2048',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 50.0,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: const [
                            ScoreBoard(),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(icon: const Icon(Icons.share), onPressed: () {}),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: () {
                            ref.watch(listProvider.notifier).state =
                                previousGrid;
                            ref.watch(scoreProvider.notifier).state =
                                previousScore;
                          }),
                      const SizedBox(width: 20.0),
                      CustomButton(
                        icon: const Icon(Icons.settings_backup_restore_rounded),
                        onPressed: () => resetGrid(ref),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 16.0),
              Screenshot(
                  controller: screenshotController,
                  child: GenerateBoard(board: ref.watch(listProvider))),
            ],
          ),
        ),
      );
    }
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

changeStates(
    WidgetRef ref,
    Tuple5<int, int, int, List<List<int>>, List<List<int>>> result,
    List<List<int>> grid) {
  ref.watch(scoreProvider.notifier).state = result.item1;
  ref.watch(highScoreProvider.notifier).state = result.item2;
  ref.watch(previousScoreProvider.notifier).state = result.item3;
  ref.watch(listProvider.notifier).state = result.item4;
  ref.watch(previousListProvider.notifier).state = result.item5;
  ref.watch(gameWonProvider.notifier).state = isGameWon(grid);
  ref.watch(gameOverProvider.notifier).state = isGameOver(grid);
}
