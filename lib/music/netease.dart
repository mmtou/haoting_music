import 'dart:convert';

import 'package:haoting_music/vo/music.dart';

import 'package:haoting_music/util/http.dart';
import 'package:haoting_music/vo/music_detail.dart';

class Netease {
  static const host = 'http://www.china-4s.com';

  static Future<List<Music>> top() async {
    String data = await Http.get('$host/top/list', param: {'idx': 1});
    Map<String, dynamic> json = jsonDecode(data);
    List<dynamic> listStr = json['playlist']['tracks'];
    List<Music> list = listStr.map((item) => Music.fromJson(item)).toList();

    return list;
  }

  static Future<List<Music>> search(String keyword) async {
    if (keyword == null || keyword.isEmpty) {
      return top();
    }

    String data = await Http.get('$host/search', param: {'keywords': keyword});
    Map<String, dynamic> json = jsonDecode(data);
    List<dynamic> listStr = json['result']['songs'];
    List<Music> list = listStr.map((item) => Music.fromJson(item)).toList();

    return list;
  }

  static Future<MusicDetail> getDetail(int id) async {
    String detailData = await Http.get('$host/song/detail', param: {'ids': id});
    Map<String, dynamic> detailJson = jsonDecode(detailData);
    Map<String, dynamic> detail = detailJson['songs'][0];

    String data = await Http.get('$host/song/url', param: {'id': id});
    Map<String, dynamic> url = jsonDecode(data)['data'][0];

    detail.addAll(url);

    return MusicDetail.fromJson(detail);
  }
}
