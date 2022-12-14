import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../animations/falling_snow.dart';

class ColdEmoji extends StatefulWidget {
  const ColdEmoji({Key? key,}) : super(key: key);

  @override
  State<ColdEmoji> createState() => _ColdEmojiState();
}

class _ColdEmojiState extends State<ColdEmoji> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0.4, 0.7],
              colors: [Colors.blue, Colors.white],
              tileMode: TileMode.repeated),
        ),
        child: Center(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.blue, Colors.lightBlueAccent],
                      ),
                    ),
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
                            Container(
                              height: 10,
                              width: 35,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Container(
                                  height: 1,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: const FallingSnow(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
