import 'dart:math';
import 'package:flutter/material.dart';

class LeafFallAnimation extends StatefulWidget {
  @override
  _LeafFallAnimationState createState() => _LeafFallAnimationState();
}

class _LeafFallAnimationState extends State<LeafFallAnimation>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late List<Widget> _leaves;
  late AnimationController _windController;
  late Animation<double> _windAnimation;

  final List<Color> autumnColors = [
    Color(0xFFDA2C1D), // Red
    Color(0xFFE8710A), // Orange
    Color(0xFFD76F30), // Light brown
    Color(0xFFBE5504), // Dark orange
    Color(0xFFFFA500), // Golden
  ];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    _windController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _windAnimation = Tween<double>(begin: -5, end: 5)
        .animate(CurvedAnimation(parent: _windController, curve: Curves.easeInOut));

    // Generate more leaves with varied sizes and colors
    _leaves = List.generate(
      40,
          (index) => Positioned(
        top: Random().nextDouble() * -300, // Start above screen
        left: Random().nextDouble() * 400,
        child: LeafWidget(
          color: autumnColors[Random().nextInt(autumnColors.length)],
          size: 20.0 + Random().nextDouble() * 20, // Random size between 20 and 40
          rotationOffset: Random().nextDouble() * 360, // Random initial rotation
        ),
      ),
    );

    _animationController.repeat();
    _windController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _windController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Autumn sky gradient background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF7BA7CF), // Light blue sky
                Color(0xFFE8C385), // Warm horizon
                Color(0xFFD89B7A), // Orange-brown ground
              ],
              stops: [0.0, 0.6, 1.0],
            ),
          ),
        ),
        // Ground shadows for depth
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 100,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.brown.withOpacity(0.3),
                ],
              ),
            ),
          ),
        ),
        // Enhanced tree
        Positioned(
          bottom: 100,
          right: MediaQuery.of(context).size.width / 3,
          child: AutumnTree(),
        ),
        // Animated falling leaves
        for (var positionedLeaf in _leaves)
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              Positioned leafPositioned = positionedLeaf as Positioned;
              return Positioned(
                top: (leafPositioned.top! + _animation.value * 800) % 700,
                left: leafPositioned.left! +
                    sin(_animation.value * 2 * pi + leafPositioned.top!) * 50 +
                    _windAnimation.value * 10,
                child: Transform.rotate(
                  angle: _animation.value * 4 * pi +
                      (leafPositioned.child as LeafWidget).rotationOffset,
                  child: leafPositioned.child,
                ),
              );
            },
          ),
        const Positioned(
          bottom: 20,
          left: 20,
          child: Text(
            "Fall",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
              shadows: [
                Shadow(
                  blurRadius: 3.0,
                  color: Colors.black45,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LeafWidget extends StatelessWidget {
  final Color color;
  final double size;
  final double rotationOffset;

  const LeafWidget({
    Key? key,
    required this.color,
    required this.size,
    required this.rotationOffset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LeafPainter(color: color),
      size: Size(size, size * 0.75),
    );
  }
}

class LeafPainter extends CustomPainter {
  final Color color;

  LeafPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width * 0.5, 0)
      ..quadraticBezierTo(0, size.height * 0.3, size.width * 0.2, size.height)
      ..quadraticBezierTo(
          size.width * 0.5, size.height * 0.8, size.width * 0.8, size.height)
      ..quadraticBezierTo(size.width, size.height * 0.3, size.width * 0.5, 0)
      ..close();

    // Add leaf veins
    final veinPaint = Paint()
      ..color = color.darken()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawPath(path, paint);

    // Draw main vein
    canvas.drawLine(
      Offset(size.width * 0.5, 0),
      Offset(size.width * 0.5, size.height),
      veinPaint,
    );

    // Draw side veins
    for (int i = 1; i <= 3; i++) {
      canvas.drawLine(
        Offset(size.width * 0.5, size.height * 0.2 * i),
        Offset(size.width * 0.2, size.height * 0.2 * i + 5),
        veinPaint,
      );
      canvas.drawLine(
        Offset(size.width * 0.5, size.height * 0.2 * i),
        Offset(size.width * 0.8, size.height * 0.2 * i + 5),
        veinPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class AutumnTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 300),
      painter: AutumnTreePainter(),
    );
  }
}

class AutumnTreePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw trunk
    final trunkPaint = Paint()
      ..color = const Color(0xFF4A2F24)
      ..style = PaintingStyle.fill;

    final trunkPath = Path()
      ..moveTo(size.width * 0.45, size.height)
      ..lineTo(size.width * 0.55, size.height)
      ..lineTo(size.width * 0.5, size.height * 0.3)
      ..close();

    canvas.drawPath(trunkPath, trunkPaint);

    // Draw branches
    final branchPaint = Paint()
      ..color = const Color(0xFF4A2F24)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    // Left branches
    drawBranch(canvas, branchPaint,
        Offset(size.width * 0.5, size.height * 0.5),
        Offset(size.width * 0.3, size.height * 0.3));
    drawBranch(canvas, branchPaint,
        Offset(size.width * 0.5, size.height * 0.4),
        Offset(size.width * 0.2, size.height * 0.2));

    // Right branches
    drawBranch(canvas, branchPaint,
        Offset(size.width * 0.5, size.height * 0.5),
        Offset(size.width * 0.7, size.height * 0.3));
    drawBranch(canvas, branchPaint,
        Offset(size.width * 0.5, size.height * 0.4),
        Offset(size.width * 0.8, size.height * 0.2));

    // Draw foliage clusters with autumn colors
    final List<Color> autumnColors = [
      const Color(0xFFDA2C1D),
      const Color(0xFFE8710A),
      const Color(0xFFD76F30),
      const Color(0xFFBE5504),
    ];

    final random = Random();
    for (int i = 0; i < 40; i++) {
      final foliagePaint = Paint()
        ..color = autumnColors[random.nextInt(autumnColors.length)]
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(
          size.width * (0.3 + random.nextDouble() * 0.4),
          size.height * (0.1 + random.nextDouble() * 0.3),
        ),
        5 + random.nextDouble() * 10,
        foliagePaint,
      );
    }
  }

  void drawBranch(Canvas canvas, Paint paint, Offset start, Offset end) {
    final path = Path()
      ..moveTo(start.dx, start.dy)
      ..lineTo(end.dx, end.dy);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Extension to darken colors for leaf veins
extension ColorExtension on Color {
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    return hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0)).toColor();
  }
}