import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class TetrisGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    debugPrint("Tetris Game Loaded");
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint = Paint()..color = Colors.blue;
    canvas.drawRect(Rect.fromLTWH(80, 80, 60, 60), paint);
  }
}
