import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import '../tap_game.dart';

class TapBox extends RectangleComponent with HasGameReference<TapGame>, TapCallbacks {
  Vector2 velocity = Vector2.zero();
  double timeSinceLastMove = 0.0;
  final Random _random = Random();

  TapBox() : super(
    size: Vector2(50, 50),
    anchor: Anchor.center,
  ) {
    paint.color = Colors.red;
  }

  @override
  void onMount() {
    super.onMount();
    _reposition();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (game.gameFinished) return;

    // Apply gravity
    velocity += game.gravity * dt;
    position += velocity * dt;

    // Boundary constraints: Floor
    if (position.y + size.y / 2 >= game.size.y) {
      position.y = game.size.y - size.y / 2;
      velocity.y = 0.0;
    }

    // Time-based randomized movement
    timeSinceLastMove += dt;
    if (timeSinceLastMove >= 1.0) {
      _reposition();
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (game.gameFinished) return;
    game.incrementScore();
    _reposition();
  }

  void _reposition() {
    timeSinceLastMove = 0.0;
    velocity = Vector2.zero();

    if (!game.size.isZero()) {
      final xMax = game.size.x - size.x;
      final yMax = game.size.y - size.y;
      
      if (xMax > 0 && yMax > 0) {
        position = Vector2(
          (size.x / 2) + _random.nextDouble() * xMax,
          (size.y / 2) + _random.nextDouble() * yMax,
        );
      } else {
        position = game.size / 2;
      }
    }
  }
}
