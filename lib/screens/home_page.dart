import 'package:flutter/material.dart';
import 'package:flutter_2048/services/controls.dart';
import 'package:flutter_2048/providers.dart';
import 'package:flutter_2048/screens/game_over_screen.dart';
import 'package:flutter_2048/services/generate_board.dart';
import 'package:flutter_2048/services/screen_shot.dart';
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

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  final ScreenshotController _screenshotController = ScreenshotController();

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
        content: const SizedBox(
          height: 70,
          child: ScoreBoard(),
        ),
        actions: [
          Center(
            child: CustomButton(
              onPressed: () => resetGrid(ref),
              icon: const Icon(Icons.restart_alt),
            ),
          ),
        ],
      );
    } else {
      return SafeArea(
        child: GestureDetector(
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
          child: Screenshot(
            controller: _screenshotController,
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
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          '2048',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.12 < 40.0
                                    ? MediaQuery.of(context).size.width * 0.12
                                    : 40.0,
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
                      CustomButton(
                          icon: const Icon(Icons.share),
                          onPressed: () =>
                              takeScreenShot(_screenshotController)),
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
                            icon: const Icon(
                                Icons.settings_backup_restore_rounded),
                            onPressed: () => resetGrid(ref),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  GenerateBoard(
                    board: grid,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
