import 'package:flutter_2048/controls.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listProvider = StateProvider<List<List<int>>>((ref) => generateNewGrid());
final previousListProvider = StateProvider<List<List<int>>>((ref) => []);
final scoreProvider = StateProvider<int>((ref) => 0);
final previousScoreProvider = StateProvider<int>((ref) => 0);
final highScoreProvider = StateProvider<int>((ref) => 0);
final gameOverProvider = StateProvider<bool>((ref) => false);
final gameWonProvider = StateProvider<bool>((ref) => false);
final canUndoProvider = StateProvider<bool>((ref) => false);
