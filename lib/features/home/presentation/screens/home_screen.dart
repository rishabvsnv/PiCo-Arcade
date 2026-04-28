import 'package:arcade/shared/models/game_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static const games = [
    GameModel(id: 'snake', title: 'Snake Classic', route: '/console/snake'),
    GameModel(id: 'tetris', title: 'Tetris', route: '/console/tetris'),
    GameModel(
      id: 'space_invaders',
      title: 'Space Invaders',
      route: '/console/space_invaders',
    ),
    GameModel(id: 'racing', title: 'Racing Pro', route: '/console/racing'),
    GameModel(id: 'tank', title: 'Tank Battle', route: '/console/tank'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PiCo Arcade'),
        actions: [
          IconButton.filled(
            onPressed: () {
              context.push('/settings');
            },
            icon: Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
      drawer: Drawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: games.length,
          itemBuilder: (context, index) {
            final game = games[index];

            return Card(
              margin: EdgeInsets.all(8),
              child: ListTile(
                leading: CircleAvatar(child: Icon(Icons.rocket)),
                title: Text(game.title),
                onTap: () => context.push(game.route),
              ),
            );
          },
        ),
      ),
    );
  }
}
