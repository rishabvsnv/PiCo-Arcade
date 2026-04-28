import 'package:arcade/features/snake/game/snake_game.dart';
import 'package:arcade/features/tetris/presentation/game/tetris_game.dart';
import 'package:arcade/shared/widgets/action_buttons.dart';
import 'package:arcade/shared/widgets/dpad.dart';
import 'package:arcade/shared/widgets/start_button.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConsoleScreen extends ConsumerStatefulWidget {
  final String game;

  const ConsoleScreen({super.key, required this.game});

  @override
  ConsumerState<ConsoleScreen> createState() => _ConsoleScreenState();
}

class _ConsoleScreenState extends ConsumerState<ConsoleScreen> {
  late FlameGame flameGame;

  @override
  void initState() {
    super.initState();
    flameGame = _loadGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color(0xFF2E6BD3),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // 🎮 GAME SCREEN
              LayoutBuilder(
                builder: (context, constraints) {
                  final maxWidth = constraints.maxWidth;
                  final maxHeight =
                      constraints.maxHeight * 0.6; // limit vertical usage

                  double width = maxWidth * 0.85;
                  double height = width * (10 / 7);

                  // 🔥 FIX: prevent overflow vertically
                  if (height > maxHeight) {
                    height = maxHeight;
                    width = height * (7 / 10);
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Center(
                      child: Container(
                        width: width,
                        height: height,
                        decoration: BoxDecoration(
                          color: const Color(0xFFB5A76A),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.black, width: 4),
                        ),
                        child: GameWidget(game: flameGame),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              // 🔘 TOP BUTTONS
              ActionButtons(
                onMode: () {
                  debugPrint("MODE");
                },
                onReset: _resetGame,
                onSound: () {
                  debugPrint("SOUND");
                },
                onPause: _togglePause,
              ),

              const SizedBox(height: 20),

              // 🎮 CONTROLS
              LayoutBuilder(
                builder: (context, constraints) {
                  final size = (constraints.maxWidth * 0.4).clamp(140.0, 220.0);

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: size,
                        height: size,
                        child: DPad(
                          onUp: () => _snake()?.moveUp(),
                          onDown: () => _snake()?.moveDown(),
                          onLeft: () => _snake()?.moveLeft(),
                          onRight: () => _snake()?.moveRight(),
                        ),
                      ),

                      SizedBox(
                        width: size * 0.6,
                        height: size * 0.6,
                        child: StartButton(
                          onStart: () {
                            if (flameGame is SnakeGame) {
                              (flameGame as SnakeGame).resetGame();
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  FlameGame _loadGame() {
    switch (widget.game) {
      case 'snake':
        return SnakeGame();
      case 'tetris':
        return TetrisGame();
      default:
        throw Exception('Unknown game: ${widget.game}');
    }
  }

  // 🔥 helpers

  SnakeGame? _snake() {
    if (flameGame is SnakeGame) {
      return flameGame as SnakeGame;
    }
    return null;
  }

  /* void _startGame() {
    flameGame.resumeEngine();
  } */

  void _togglePause() {
    if (flameGame.paused) {
      flameGame.resumeEngine();
    } else {
      flameGame.pauseEngine();
    }
  }

  void _resetGame() {
    setState(() {
      flameGame = _loadGame(); // recreate clean state
    });
  }
}
