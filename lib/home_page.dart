// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game/mycontroller.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyController());
    controller.isHide.value = false;
    return Scaffold(
      body: Obx(
        () => SafeArea(
          child: ListView(
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Text(
                    "Kithya Kla Klouk App",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 50,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(
                  child: SizedBox(
                    width: 400,
                    height: 400,
                    child: Stack(children: [
                      Positioned(
                          left: 0,
                          //left: 20,
                          top: 0,
                          child: bowl(imagePath: "assets/Top-view-bowl.png")),
                      Positioned(
                          top: 50,
                          left: 140,
                          child: resultCard(controller.result1.value)),
                      Positioned(
                        top: 200,
                        left: 90,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            resultCard(controller.result2.value),
                            const SizedBox(
                              width: 20,
                            ),
                            resultCard(controller.result3.value),
                          ],
                        ),
                      ),
                      Positioned(
                          left: 0,
                          //left: 20,
                          top: 0,
                          child: controller.isHide.value
                              ? bowl(imagePath: "assets/Cover-bowl.png")
                              : Container()),
                    ]),
                  ),
                ),
              ),
              // Text("Result1=${controller.result1.value}"),
              // Text("Result2=${controller.result2.value}"),
              // Text("Result3=${controller.result3.value}"),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        controller.isHide.value = true;
                        controller.isStop.value = false;
                        const threeSecond = Duration(seconds: 3);
                        controller.timerAudio = Timer.periodic(
                          threeSecond,
                          (Timer timer) {
                            if (controller.isStop.value == true) {
                              timer.cancel();
                              controller.update();
                            } else {
                              controller.playAudio("assets/audio/shake.mp3");
                            }
                          },
                        );
                        const oneSec = Duration(milliseconds: 200);
                        controller.timer = Timer.periodic(
                          oneSec,
                          (Timer timer) {
                            if (controller.isStop.value == true) {
                              timer.cancel();
                              controller.update();
                            } else {
                              controller.spin();
                            }
                          },
                        );

                        //controller.isHide.value = true;
                        //debugPrint("${controller.isHide.value}");

                        // Future.delayed(
                        //   const Duration(seconds: 2),
                        //   () {
                        //     controller.isHide.value = false;
                        //     controller
                        //         .playAudio("assets/audio/Rolling-dice.mp3");
                        //   },
                        // );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Spin",
                          style: TextStyle(fontSize: 50),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    RaisedButton(
                      onPressed: () {
                        controller.isStop.value = true;
                        controller.isHide.value = false;
                        debugPrint("${controller.isStop.value}");
                        controller.playAudio("assets/audio/Rolling-dice.mp3");
                        // controller.spin();

                        // controller.playAudio("assets/audio/shake.mp3");
                        // controller.isHide.value = true;
                        // debugPrint("${controller.isHide.value}");

                        // Future.delayed(
                        //   const Duration(seconds: 2),
                        //   () {
                        //     controller.isHide.value = false;
                        //     controller
                        //         .playAudio("assets/audio/Rolling-dice.mp3");
                        //   },
                        // );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Stop",
                          style: TextStyle(fontSize: 50),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget bowl({String? imagePath}) {
  return SizedBox(
    width: 400,
    height: 380,
    child: Image.asset("$imagePath", fit: BoxFit.fill),
  );
}

Widget resultCard(int? result) {
  final controller = Get.put(MyController());
  return Container(
    width: 100,
    height: 100,
    decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(blurRadius: 7)]),
    child: result! > 0 && result <= 6
        ? Image.asset(controller.convertImageFromInt(result))
        : const Text("null"),
  );
}
