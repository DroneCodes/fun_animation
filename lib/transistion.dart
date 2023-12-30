import 'package:flutter/material.dart';
import 'package:fun_animation/animations/falling_leaves.dart';

import 'dart:async';

import 'package:fun_animation/animations/summer.dart';

import 'animations/snow_fall.dart';
import 'animations/spring_season.dart';
class Transition extends StatefulWidget {
  @override
  _TransitionState createState() => _TransitionState();
}

class _TransitionState extends State<Transition> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: _currentPage);

    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 3) {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      } else {
        // Reset to the first page after reaching the last one
        _currentPage = 0;
        _pageController.jumpToPage(0);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          children: [
            SpringPage(),
            SummerPage(),
            LeafFallAnimation(),
            SnowFallAnimation(),
          ],
        ),
      ),
    );
  }
}
