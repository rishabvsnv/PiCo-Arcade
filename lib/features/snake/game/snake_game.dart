import 'dart:math';
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

  Vector2 food = Vector2.zero();
  int score = 0;
  final Random _random = Random();

  bool isGameOver = false;

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _initGame();
  }

  void _initGame() {
    cols = (size.x / cellSize).floor();
    rows = (size.y / cellSize).floor();

    snake = [Vector2((cols ~/ 2).toDouble(), (rows ~/ 2).toDouble())];
    direction = Direction.right;
    score = 0;
    moveTimer = 0;
    isGameOver = false;

    _spawnFood();
  }

  void resetGame() {
    _initGame();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (isGameOver) return;

    moveTimer += dt;

    final speed = (moveInterval - (score * 0.005)).clamp(0.08, moveInterval);

    if (moveTimer >= speed) {
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

    // Wall collision
    if (newHead.x < 0 ||
        newHead.y < 0 ||
        newHead.x >= cols ||
        newHead.y >= rows) {
      isGameOver = true;
      return;
    }

    // Self collision
    if (snake.any((s) => s.x == newHead.x && s.y == newHead.y)) {
      isGameOver = true;
      return;
    }

    snake.insert(0, newHead);

    // Food
    if (newHead.x == food.x && newHead.y == food.y) {
      score++;
      _spawnFood();
    } else {
      snake.removeLast();
    }
  }

  void _spawnFood() {
    final emptySpaces = <Vector2>[];

    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
        final pos = Vector2(x.toDouble(), y.toDouble());

        if (!snake.any((s) => s.x == pos.x && s.y == pos.y)) {
          emptySpaces.add(pos);
        }
      }
    }

    if (emptySpaces.isEmpty) {
      isGameOver = true;
      return;
    }

    food = emptySpaces[_random.nextInt(emptySpaces.length)];
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final snakePaint = Paint()..color = Colors.green;

    for (final s in snake) {
      canvas.drawRect(
        Rect.fromLTWH(
          s.x * cellSize,
          s.y * cellSize,
          cellSize.toDouble(),
          cellSize.toDouble(),
        ),
        snakePaint,
      );
    }

    final foodPaint = Paint()..color = Colors.red;

    canvas.drawRect(
      Rect.fromLTWH(
        food.x * cellSize,
        food.y * cellSize,
        cellSize.toDouble(),
        cellSize.toDouble(),
      ),
      foodPaint,
    );

    // Score
    final tp = TextPainter(
      text: TextSpan(
        text: 'Score: $score',
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    tp.layout();
    tp.paint(canvas, const Offset(8, 8));

    // Game Over text
    if (isGameOver) {
      final over = TextPainter(
        text: const TextSpan(
          text: 'GAME OVER\nPress START',
          style: TextStyle(
            color: Colors.red,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      over.layout();
      over.paint(
        canvas,
        Offset((size.x - over.width) / 2, (size.y - over.height) / 2),
      );
    }
  }

  // Controls
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
