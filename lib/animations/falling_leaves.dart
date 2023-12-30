import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fun_animation/widgets/leafWidget.dart';
import 'package:fun_animation/widgets/treeWidget.dart';

class LeafFallAnimation extends StatefulWidget {
  @override
  _LeafFallAnimationState createState() => _LeafFallAnimationState();
}

class _LeafFallAnimationState extends State<LeafFallAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late List<Widget> _leaves;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    _leaves = List.generate(
      20,
      (index) => Positioned(
        top: Random().nextDouble() * 400,
        left: Random().nextDouble() * 400,
        child: LeafWidget(),
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
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFEDCBA0), Color(0xFFE58F65)],
                ),
              ),
            ),
            // Tree
            Positioned(
              top: 50,
              right: 180,
              child: TreeWidget(),
            ),
            // Falling leaves
            for (var positionedLeaf in _leaves)
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  Positioned leafPositioned = positionedLeaf as Positioned;
                  return Positioned(
                    top: leafPositioned.top! + _animation.value * 300,
                    left: leafPositioned.left! + _animation.value * 300,
                    child: leafPositioned.child,
                  );
                },
              ),

            const Positioned(
              bottom: 20,
              left: 20,
              child: Text(
                "Fall",
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



