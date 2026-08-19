import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'components/tap_box.dart';

class TapGame extends FlameGame {
  final void Function(int) onGameOver;
  TapGame({required this.onGameOver});

  int totalTapCount = 0;
  double timeLeft = 30.0;
  bool gameFinished = false;

  final Vector2 gravity = Vector2(0, 100);

  late TextComponent scoreText;
  late TextComponent timerText;

  @override
  Future<void> onLoad() async {
    scoreText = TextComponent(
      text: 'Score: $totalTapCount',
      position: Vector2(10, 10),
    );
    add(scoreText);

    timerText = TextComponent(
      text: 'Time: ${timeLeft.toStringAsFixed(1)}',
      position: Vector2(10, 40),
    );
    add(timerText);

    add(TapBox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameFinished) return;

    timeLeft -= dt;
    // Cap at 0 so it doesn't show negative seconds
    timerText.text = 'Time: ${timeLeft > 0 ? timeLeft.toStringAsFixed(1) : "0.0"}';

    if (timeLeft <= 0) {
      gameFinished = true;
      onGameOver(totalTapCount);
    }
  }

  void incrementScore() {
    totalTapCount++;
    scoreText.text = 'Score: $totalTapCount';
  }
}
