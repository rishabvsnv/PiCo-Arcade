import 'package:flame/game.dart';
import 'package:flutter/material.dart';

enum Direction { up, down, left, right }

class SnakeGame extends FlameGame {
  static const int cellSize = 20;

  late int rows;
  late int cols;

  List<Vector2> snake = [];
  Direction direction = Direction.right;

  double moveTimer = 0;
  final double moveInterval = 0.2;

  @override
  Future<void> onLoad() async {
    pauseEngine(); // start paused
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    cols = (size.x / cellSize).floor();
    rows = (size.y / cellSize).floor();

    // initialize snake in center
    snake = [Vector2((cols ~/ 2).toDouble(), (rows ~/ 2).toDouble())];
  }

  @override
  void update(double dt) {
    super.update(dt);

    moveTimer += dt;

    if (moveTimer >= moveInterval) {
      moveTimer = 0;
      _moveSnake();
    }
  }

  void _moveSnake() {
    final head = snake.first;
    Vector2 newHead;

    switch (direction) {
      case Direction.up:
        newHead = Vector2(head.x, head.y - 1);
        break;
      case Direction.down:
        newHead = Vector2(head.x, head.y + 1);
        break;
      case Direction.left:
        newHead = Vector2(head.x - 1, head.y);
        break;
      case Direction.right:
        newHead = Vector2(head.x + 1, head.y);
        break;
    }

    // 🔥 boundary check (FIX)
    if (newHead.x < 0 ||
        newHead.y < 0 ||
        newHead.x >= cols ||
        newHead.y >= rows) {
      pauseEngine();
      debugPrint("Game Over - hit wall");
      return;
    }

    // move snake
    snake.insert(0, newHead);
    snake.removeLast();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint = Paint()..color = Colors.green;

    for (final segment in snake) {
      canvas.drawRect(
        Rect.fromLTWH(
          segment.x * cellSize,
          segment.y * cellSize,
          cellSize.toDouble(),
          cellSize.toDouble(),
        ),
        paint,
      );
    }
  }

  // 🎮 controls
  void moveUp() {
    if (direction != Direction.down) direction = Direction.up;
  }

  void moveDown() {
    if (direction != Direction.up) direction = Direction.down;
  }

  void moveLeft() {
    if (direction != Direction.right) direction = Direction.left;
  }

  void moveRight() {
    if (direction != Direction.left) direction = Direction.right;
  }
}
