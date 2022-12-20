import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_2048/utils/colors.dart';
import 'package:flutter_2048/widgets/tile.dart';

class GenerateBoard extends StatelessWidget {
  final List<List<int>> board;
  const GenerateBoard({super.key, required this.board});

  @override
  Widget build(BuildContext context) {
    //Decides the maximum size the Board can be based on the shortest size of the screen.
    final size = max(
        290.0,
        min((MediaQuery.of(context).size.shortestSide * 0.90).floorToDouble(),
            460.0));
    final sizePerTile = (size / 4).floorToDouble();
    final tileSize = sizePerTile - 12.0 - (12.0 / 4);
    final boardSize = sizePerTile * 4;
    return Container(
      width: boardSize,
      height: boardSize,
      decoration: BoxDecoration(
        color: boardColor,
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Stack(
        children: [
          for (var i = 0; i < 16; i++)
            Positioned(
              left: (i % 4) * sizePerTile + 6.0,
              top: (i / 4).floor() * sizePerTile + 6.0,
              child: Tile(
                value: board[i % 4][i ~/ 4],
                fontSize: tileSize / 3,
                size: tileSize,
              ),
            ),
        ],
      ),
    );
  }
}
