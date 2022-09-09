import 'dart:async';
import 'dart:math';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyController extends GetxController {
  var result1 = 1.obs;
  var result2 = 2.obs;
  var result3 = 3.obs;
  var isHide = false.obs;
  var isStop = true.obs;
  late final AudioCache audioCache;
  Timer? timer;
  Timer? timerAudio;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    audioCache = AudioCache(
      prefix: 'audio/',
      fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer!.cancel();
    timerAudio!.cancel();
  }

  void spin() {
    Random random = Random();
    final list = List.generate(3, (_) => random.nextInt(6) + 1);
    // for (var element in list) {
    //   print("Value===$element");
    // }
    result1.value = list[0];
    result2.value = list[1];
    result3.value = list[2];

    print("result1.value=${result1.value}\n"
        "result2.value=${result2.value}\n"
        "result2.value=${result3.value}\n");
  }

  final assetsAudioPlayer = AssetsAudioPlayer();

  void playAudio(String path) {
    // if (kIsWeb) {
    //   js.context.callMethod('playAudio', [path]);
    //   print("web");
    // } else {
    // audioCache.play(path);
    // print("mobile");
    //}
    if (kIsWeb) {
      // function playAudio(path) {
      //   audio= new Howl({
      //     src: [path]
      //   });
      //   audio.play();
      // }
      // running on the web!
      try {
        assetsAudioPlayer.open(
          Audio(path),
        );
      } catch (e) {
        debugPrint("$e");
      }

      debugPrint("web");
    } else {
      // running on the web!
      try {
        assetsAudioPlayer.open(
          Audio(path),
        );
      } catch (e) {
        debugPrint("$e");
      }
      // NOT running on the web! You can check for additional platforms here.
    }
  }

  String convertImageFromInt(int result) {
    switch (result) {
      case 1:
        return "assets/Kla.png";
      case 2:
        return "assets/Klouk.png";
      case 3:
        return "assets/Chicken.png";
      case 4:
        return "assets/lobster.png";
      case 5:
        return "assets/Crab.png";
      case 6:
        return "assets/fish.png";
    }
    return "";
  }
}
