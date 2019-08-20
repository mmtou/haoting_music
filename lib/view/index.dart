import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:haoting_music/music/netease.dart';
import 'package:haoting_music/util/custom_theme.dart';
import 'package:haoting_music/util/music_player.dart';
import 'package:haoting_music/view/player.dart';
import 'package:haoting_music/vo/music.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> with AutomaticKeepAliveClientMixin {
  List<Music> _list = [];
  List<String> _favorites = [];

  TextEditingController keywordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    top();
  }

  @override
  void dispose() {
    keywordController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  Future readFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites');
    favorites = favorites == null ? [] : favorites;
    setState(() {
      this._favorites = favorites;
    });
  }

  Future top() async {
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        return Center(
//          child: CircularProgressIndicator(),
//        );
//      },
//      barrierDismissible: false,
//    );
    await readFavorites();
    var list = await Netease.top();
    setState(() {
      _list = list;
    });
  }

  Future search(keyword) async {
    await readFavorites();
    var list = await Netease.search(keyword);
    setState(() {
      _list = list;
    });
  }

  Future favorite(Music music) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = prefs.getStringList('favorites');
    list = list == null ? [] : list;
    String item = jsonEncode(music);
    if (!list.contains(item)) {
      list.insert(0, item);
      _favorites.insert(0, item);
    } else {
      list.remove(item);
      _favorites.remove(item);
    }
    prefs.setStringList('favorites', list);
    setState(() {
      this._favorites = list;
    });
  }

  selectTheme() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                var key = CustomTheme.themeKeys[index];
                ThemeItem item = CustomTheme.themes[key];
                return Container(
                  color: item.primaryColor,
                  margin: EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(
                      key,
                      style: TextStyle(color: item.iconColor),
                    ),
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('theme', key);
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text('重启应用后生效'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text('我知道了'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 1.0,
                );
              },
              itemCount: CustomTheme.themeKeys.length),
        );
      },
    );
  }

  selectChannel() {
    const channels = [
      {'name': '网易云音乐', 'available': true},
      {'name': 'QQ音乐', 'available': false},
      {'name': '虾米音乐', 'available': false}
    ];
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 216.0,
          child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                var item = channels[index];
                return ListTile(
                  title: Text(item['name']),
                  subtitle: item['available'] ? null : Text('敬请期待'),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 1.0,
                );
              },
              itemCount: channels.length),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: '输入关键字搜索',
            hintStyle: TextStyle(color: CustomTheme.theme.iconColor),
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: CustomTheme.theme.iconColor,
            ),
          ),
          style: TextStyle(color: CustomTheme.theme.iconColor),
          controller: keywordController,
          onSubmitted: (keyword) {
            search(keyword);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: selectTheme,
          ),
          IconButton(
            icon: Icon(Icons.repeat),
            onPressed: selectChannel,
          )
        ],
        elevation: 0,
      ),
      body: _list == null || _list.isEmpty
          ? Center(
              child: Text('无数据'),
            )
          : RefreshIndicator(
              onRefresh: top,
              child: ListView.separated(
                itemCount: _list.length,
                separatorBuilder: (content, index) {
                  return Divider(
                    height: 1.0,
                  );
                },
                itemBuilder: (content, i) {
                  Music item = _list[i];
                  List<String> alia = item.alia;
                  return ListTile(
                    title: Text(
                      item.name +
                          (alia != null && alia.isNotEmpty
                              ? '(' + alia.join(',') + ')'
                              : ''),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(item.artists
                        .map((item) => item.name)
                        .toList()
                        .join(',')),
                    trailing: IconButton(
                      icon: Icon(_favorites.contains(jsonEncode(item))
                          ? Icons.favorite
                          : Icons.favorite_border),
                      onPressed: () {
                        favorite(item);
                      },
                    ),
                    onTap: () {
                      MusicPlayer.setList(_list);
                      Navigator.of(context).push(MaterialPageRoute<void>(
                          builder: (context) => Player(item.id)));
                    },
                  );
                },
              ),
            ),
      backgroundColor: CustomTheme.theme.backgroundColor,
    );
  }
}
