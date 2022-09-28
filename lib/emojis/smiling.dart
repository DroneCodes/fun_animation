import 'package:flutter/material.dart';

class SmilingEmoji extends StatefulWidget {
  const SmilingEmoji({Key? key}) : super(key: key);

  @override
  State<SmilingEmoji> createState() => _SmilingEmojiState();
}

class _SmilingEmojiState extends State<SmilingEmoji> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [0.4, 0.7],
            colors: [Colors.orangeAccent, Colors.white],
            tileMode: TileMode.repeated),
      ),
      child: Center(
        child: Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100), color: Colors.orange),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 12,
                        width: 7,
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        height: 12,
                        width: 7,
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10),),
                    child: Container(
                      height: 0.5,
                      width: 35,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

