import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:haoting_music/vo/music.dart';

class MusicPlayer {
  static AudioPlayer audioPlayer = AudioPlayer();

  static List<int> idList = [];
  static int currentId;

  static setList(List<Music> list) {
    idList.clear();
    list.map((item) => idList.add(item.id)).toList();
  }

  static Future<bool> play(int id, String url) async {
    int result = await audioPlayer.play(url);
    if (1 == result) {
      currentId = id;
      return true;
    }
    return false;
  }

  static resume() async {
    await audioPlayer.resume();
  }

  static pause() async {
    await audioPlayer.pause();
  }

  static stop() async {
    await audioPlayer.stop();
    await audioPlayer.release();
  }

  static seek(int milliseconds) async {
    await audioPlayer.seek(Duration(milliseconds: milliseconds));
  }

  static Future<int> getDuration() async {
    return await audioPlayer.getDuration();
  }

  static Future<int> pre() async {
    await audioPlayer.release();
    int index = idList.indexOf(currentId);
    int id = idList[max(index - 1, 0)];
    return id;
  }

  static Future<int> next() async {
    await audioPlayer.release();
    int index = idList.indexOf(currentId);
    int id = idList[min(index + 1, idList.length - 1)];
    return id;
  }
}
