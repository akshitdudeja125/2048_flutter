import 'package:flutter/material.dart';
import 'package:flutter_2048/utils/colors.dart';

class Tile extends StatefulWidget {
  final int value;
  final double fontSize;
  final double size;
  const Tile(
      {super.key,
      required this.value,
      required this.fontSize,
      required this.size});

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        color: widget.value == 0 ? emptyTileColor : tileColors[widget.value],
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Center(
        child: Text(
          widget.value.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: widget.fontSize,
            color: widget.value == 0 ? emptyTileColor : textColor,
          ),
        ),
      ),
    );
  }
}
