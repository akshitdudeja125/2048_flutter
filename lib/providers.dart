import 'package:flutter_2048/services/controls.dart';
import 'dart:math';
import 'package:tuple/tuple.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listProvider = StateProvider<List<List<int>>>((ref) => generateNewGrid());
final previousListProvider =
    StateProvider<List<List<int>>>((ref) => ref.watch(listProvider));
final scoreProvider = StateProvider<int>((ref) => 0);
final previousScoreProvider = StateProvider<int>((ref) => 0);
final highScoreProvider = StateProvider<int>((ref) => 0);
final gameOverProvider = StateProvider<bool>((ref) => false);
final gameWonProvider = StateProvider<bool>((ref) => false);
final canUndoProvider = StateProvider<bool>((ref) => false);

resetGrid(WidgetRef ref) {
  ref.watch(listProvider.notifier).state = generateNewGrid();
  ref.watch(highScoreProvider.notifier).state =
      max(ref.watch(highScoreProvider), ref.watch(scoreProvider));
  ref.watch(scoreProvider.notifier).state = 0;
  ref.watch(previousScoreProvider.notifier).state = 0;
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
