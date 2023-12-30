import 'package:flutter/material.dart';

class TreeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: 220,
            height: 150,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              color: Colors.green,
            )),
        Container(
          width: 20,
          height: 150,
          color: Colors.brown,
        ),
      ],
    );
  }
}