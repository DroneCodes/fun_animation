import 'package:flutter/material.dart';

class SummerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF87CEFA), // Light Sky Blue
              Color(0xFFFFFACD), // Lemon Chiffon
            ],
          ),
        ),
        child: Stack(
          children: [
            // Sun
            Positioned(
              top: 50,
              left: 50,
              child: SunWidget(),
            ),
            const Positioned(
              bottom: 20,
              left: 20,
              child: Text(
                "Summer",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class SunWidget extends StatefulWidget {
  @override
  _SunWidgetState createState() => _SunWidgetState();
}

class _SunWidgetState extends State<SunWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _sunAnimationController;
  late Animation<Color?> _sunColorAnimation;
  late Animation<double> _horizontalMoveAnimation;

  @override
  void initState() {
    super.initState();

    _sunAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat(reverse: true);

    _sunColorAnimation = ColorTween(
      begin: Colors.yellow.shade700,
      end: Colors.orange.shade700,
    ).animate(
      CurvedAnimation(
        parent: _sunAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _horizontalMoveAnimation = Tween<double>(
      begin: -50.0, // Start slightly off-screen to the left
      end: 250.0, // Move to the right
    ).animate(
      CurvedAnimation(
        parent: _sunAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _sunAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _sunAnimationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_horizontalMoveAnimation.value, 0.0),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _sunColorAnimation.value,
              boxShadow: [
                BoxShadow(
                  color: _sunColorAnimation.value?.withOpacity(0.5) ?? Colors.transparent,
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


