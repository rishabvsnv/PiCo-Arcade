// import 'package:arcade/features/home/presentation/screens/home_screen.dart';
import 'package:arcade/features/settings/presentation/settings_screen.dart';
import 'package:arcade/features/console/presentation/screens/console_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      // GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/',
        builder: (context, state) => const ConsoleScreen(game: 'snake'),
      ),
      /* GoRoute(
        path: '/console/:game',
        builder: (context, state) {
          final game = state.pathParameters['game']!;
          return ConsoleScreen(game: game);
        },
      ), */
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
});
