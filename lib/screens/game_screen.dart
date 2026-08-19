import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../tap_game.dart';
import 'result_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late TapGame game;

  @override
  void initState() {
    super.initState();
    game = TapGame(
      onGameOver: (score) {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => ResultScreen(score: score),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GameWidget(game: game),
      ),
    );
  }
}
