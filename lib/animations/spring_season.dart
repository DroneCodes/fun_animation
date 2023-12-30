import 'package:flutter/material.dart';

class SpringPage extends StatefulWidget {
  @override
  _SpringPageState createState() => _SpringPageState();
}

class _SpringPageState extends State<SpringPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _flowerAnimationController;
  late Animation<double> _flowerAnimation;

  @override
  void initState() {
    super.initState();

    _flowerAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _flowerAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _flowerAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _flowerAnimationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _flowerAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8FBC8F), // Dark Olive Green
              Color(0xFF98FB98), // Pale Green
            ],
          ),
        ),
        child: Stack(
          children: [
            // Blooming flowers
            Positioned(
              top: 320,
              left: 350,
              child: AnimatedBuilder(
                animation: _flowerAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 1 + _flowerAnimation.value,
                    child: FlowerWidget(),
                  );
                },
              ),
            ),
            Positioned(
              top: 420,
              right: 350,
              child: AnimatedBuilder(
                animation: _flowerAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 1 + _flowerAnimation.value,
                    child: FlowerWidget(),
                  );
                },
              ),
            ),
            Positioned(
              top: 320,
              right: 350,
              child: AnimatedBuilder(
                animation: _flowerAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 1 + _flowerAnimation.value,
                    child: FlowerWidget(),
                  );
                },
              ),
            ),
            Positioned(
              top: 250,
              left: 200,
              child: AnimatedBuilder(
                animation: _flowerAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 1 + _flowerAnimation.value,
                    child: FlowerWidget(),
                  );
                },
              ),
            ),
            Positioned(
              top: 350,
              left: 150,
              child: AnimatedBuilder(
                animation: _flowerAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 1 + _flowerAnimation.value,
                    child: FlowerWidget(),
                  );
                },
              ),
            ),
            Positioned(
              top: 400,
              left: 300,
              child: AnimatedBuilder(
                animation: _flowerAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 1 + _flowerAnimation.value,
                    child: FlowerWidget(),
                  );
                },
              ),
            ),
            // Clouds at the top
            Positioned(
              top: 20,
              left: 120,
              child: CloudWidget(),
            ),
            Positioned(
              top: 100,
              right: 80,
              child: CloudWidget(),
            ),
            Positioned(
              top: 50,
              left: 250,
              child: CloudWidget(),
            ),
            Positioned(
              top: 50,
              right: 150,
              child: CloudWidget(),
            ),

            const Positioned(
              bottom: 20,
              left: 20,
              child: Text(
                "Spring",
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

class FlowerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.pink,
      ),
      child: Center(
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.yellow,
          ),
        ),
      ),
    );
  }
}


class CloudWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      child: CustomPaint(
        painter: CloudPainter(),
      ),
    );
  }
}

class CloudPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(30, 60)
      ..quadraticBezierTo(10, 60, 10, 40)
      ..quadraticBezierTo(10, 20, 30, 20)
      ..quadraticBezierTo(40, 5, 60, 20)
      ..quadraticBezierTo(80, 5, 90, 20)
      ..quadraticBezierTo(110, 20, 110, 40)
      ..quadraticBezierTo(110, 60, 90, 60)
      ..quadraticBezierTo(80, 75, 60, 60)
      ..quadraticBezierTo(40, 75, 30, 60);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
