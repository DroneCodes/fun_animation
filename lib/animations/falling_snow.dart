import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fun_animation/emojis/cold.dart';

class FallingSnow extends StatefulWidget {
  final VoidCallback? onEnd;
  const FallingSnow({Key? key, this.onEnd,}) : super(key: key);

  @override
  State<FallingSnow> createState() => _FallingSnowState();
}

class _FallingSnowState extends State<FallingSnow> with SingleTickerProviderStateMixin{

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1500,
      ),
    );

    _animation = Tween<double>(
      begin: -150.0,
      end: 350.0,
    ).animate(_controller);

    _animation.addListener(() {
      setState(() {});
    });

    _controller.forward();

    if(widget.onEnd != null) {
      widget.onEnd!();
    }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Transform.translate(
              offset: Offset(0, _animation.value),
              child: Container(
                height: 500,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        CupertinoIcons.snow,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Icon(
                        CupertinoIcons.snow,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Icon(
                        CupertinoIcons.snow,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Icon(
                        CupertinoIcons.snow,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        CupertinoIcons.snow,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        CupertinoIcons.snow,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
