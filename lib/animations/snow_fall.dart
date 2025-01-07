import 'dart:math';
import 'package:flutter/material.dart';

class SnowFallAnimation extends StatefulWidget {
  @override
  _SnowFallAnimationState createState() => _SnowFallAnimationState();
}

class _SnowFallAnimationState extends State<SnowFallAnimation>
    with TickerProviderStateMixin {  // <-- Changed this line
  late AnimationController _animationController;
  late Animation<double> _animation;
  late List<Widget> _snowflakes;
  late AnimationController _shiverController;
  late Animation<double> _shiverAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    _snowflakes = List.generate(
      40,
          (index) => Positioned(
        top: Random().nextDouble() * 400,
        left: Random().nextDouble() * 400,
        child: SnowflakeWidget(),
      ),
    );

    _shiverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _shiverAnimation = Tween<double>(begin: -5, end: 5).animate(
      CurvedAnimation(
        parent: _shiverController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.repeat();
    _shiverController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _shiverController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background with winter theme
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF1A237E), // Darker blue for winter sky
                Color(0xFF3949AB), // Medium blue
                Color(0xFFE3F2FD), // Light blue near horizon
                Colors.white, // Snow on ground
              ],
              stops: [0.0, 0.3, 0.6, 0.8],
            ),
          ),
        ),
        // Snow ground
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 100,
          child: CustomPaint(
            painter: SnowGroundPainter(),
          ),
        ),
        // Falling snowflakes
        for (var positionedSnowflake in _snowflakes)
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              Positioned snowflakePositioned = positionedSnowflake as Positioned;
              return Positioned(
                top: (snowflakePositioned.top! + _animation.value * 400) % 400,
                left: snowflakePositioned.left! +
                    sin(_animation.value * 2 * pi) * 10,
                child: snowflakePositioned.child,
              );
            },
          ),
        // Shivering character
        Positioned(
          bottom: 120,
          left: 180,
          child: AnimatedBuilder(
            animation: _shiverAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_shiverAnimation.value, 0),
                child: const ShiveringCharacter(),
              );
            },
          ),
        ),
        const Positioned(
          bottom: 20,
          left: 20,
          child: Text(
            "Winter",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ],
    );
  }
}

class SnowflakeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.ac_unit,
      color: Colors.white,
      size: 20,
    );
  }
}

class ShiveringCharacter extends StatelessWidget {
  const ShiveringCharacter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Head
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.brown,
            shape: BoxShape.circle,
          ),
        ),
        // Body
        Container(
          width: 60,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.blue[800],
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        // Arms
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: -0.3,
              child: Container(
                width: 20,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Transform.rotate(
              angle: 0.3,
              child: Container(
                width: 20,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
        // Legs
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 20,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 20,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SnowGroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..quadraticBezierTo(
        size.width * 0.75,
        size.height * 0.25,
        size.width * 0.5,
        0,
      )
      ..quadraticBezierTo(
        size.width * 0.25,
        size.height * 0.25,
        0,
        0,
      )
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}