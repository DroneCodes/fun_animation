import 'dart:math';
import 'package:flutter/material.dart';
import '../widgets/snowFlakeWidget.dart';

class SnowFallAnimation extends StatefulWidget {
  @override
  _SnowFallAnimationState createState() => _SnowFallAnimationState();
}

class _SnowFallAnimationState extends State<SnowFallAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late List<Widget> _snowflakes;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    _snowflakes = List.generate(
      20,
          (index) => Positioned(
        top: Random().nextDouble() * 400,
        left: Random().nextDouble() * 400,
        child: SnowflakeWidget(),
      ),
    );

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Stack(
          children: [
            // Background with winter theme
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFB0E0E6), Color(0xFF87CEFA)],
                ),
              ),
            ),
            // Falling snowflakes
            for (var positionedSnowflake in _snowflakes)
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  Positioned snowflakePositioned =
                  positionedSnowflake as Positioned;
                  return Positioned(
                    top: snowflakePositioned.top! +
                        _animation.value * 400, // Adjust the value to control the fall speed
                    left: snowflakePositioned.left!, // Constant horizontal position
                    child: snowflakePositioned.child,
                  );
                },
              ),

            const Positioned(
              bottom: 20,
              left: 20,
              child: Text(
                "Winter",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
