import 'package:flutter/material.dart';
import '../animations/random_falling_snow.dart';

class ColdEmoji extends StatefulWidget {
  const ColdEmoji({Key? key}) : super(key: key);

  @override
  State<ColdEmoji> createState() => _ColdEmojiState();
}

class _ColdEmojiState extends State<ColdEmoji> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [0.4, 0.7],
            colors: [Colors.lightBlue, Colors.white],
            tileMode: TileMode.repeated,
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              for (int index = 0; index < 50; index++)
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.lightBlue, Colors.blue],
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
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  height: 12,
                                  width: 7,
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
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
                                color: Colors.lightBlueAccent,
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
                child: SnowDrop(
                  screenHeight: size.height,
                  screenWidth: size.width,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
