import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnowDrop extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;

  const SnowDrop({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
  }) : super(key: key);

  @override
  State<SnowDrop> createState() => _SnowDropState();
}

class _SnowDropState extends State<SnowDrop> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;
  late double dx, dy, length, z;
  bool isVisible = true;

  Random random = Random();

  double get screenHeight => widget.screenHeight;

  double get screenWidth => widget.screenWidth;

  double rangeMap(
      double x,
      double inMin,
      double inMax,
      double outMin,
      double outMax,
      ) {
    return (x - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;
  }

  animationListener() {
    if (animationController.status == AnimationStatus.completed) {
      isVisible = false;
      setState(() {});
      animationController.reset();
      z = random.nextDouble() * 20;
      length = rangeMap(z, 0, 20, 10, 20);
      animationController.duration = Duration(
        milliseconds: rangeMap(z, 0, 20, 800, 3000).toInt(),
      );
      dx = random.nextDouble() * screenWidth;
      dy = -20; // Set starting y position just above the screen
      setState(() {});
      isVisible = true;
      if (mounted) animationController.forward();
    }
  }

  @override
  void initState() {
    super.initState();
    dx = random.nextDouble() * screenWidth;
    dy = random.nextDouble() * screenHeight;
    z = random.nextDouble() * 20;
    length = rangeMap(z, 0, 20, 10, 20);
    animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: rangeMap(z, 0, 20, 800, 3000).toInt(),
      ),
    );
    animation = Tween<double>(begin: dy, end: screenHeight).animate(
      animationController,
    );
    animationController.forward();

    animationController.addListener(animationListener);
  }

  @override
  void dispose() {
    super.dispose();
    animationController.removeListener(animationListener);
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              dx,
              animation.value,
            ),
            child: const Icon(
              CupertinoIcons.snow,
              color: Colors.white,
              size: 10,
            ),
          );
        },
      ),
    );
  }
}
