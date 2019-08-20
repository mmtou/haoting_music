import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:haoting_music/util/custom_theme.dart';
import 'package:haoting_music/util/music_player.dart';
import 'package:haoting_music/view/player.dart';
import 'package:haoting_music/vo/music.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite>
    with AutomaticKeepAliveClientMixin {
  List<Music> _favorites = [];

  @override
  void initState() {
    super.initState();
    get();
  }

  @override
  bool get wantKeepAlive => true;

  Future get() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites');
    if (favorites != null) {
      setState(() {
        this._favorites =
            favorites.map((item) => Music.fromJson(jsonDecode(item))).toList();
      });
    }
  }

  clearAll() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('确定要清空收藏歌曲吗？'),
          actions: <Widget>[
            FlatButton(
              child: Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('确定'),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('favorites');
                setState(() {
                  this._favorites = [];
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  more(i) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 100,
          child: ListView.separated(
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return ListTile(
                      title: Text('移除'),
                      leading: Icon(Icons.remove_circle_outline),
                      onTap: () async {
                        setState(() {
                          this._favorites.removeAt(i);
                        });
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setStringList(
                            'favorites',
                            this
                                ._favorites
                                .map((item) => jsonEncode(item))
                                .toList());
                        Navigator.of(context).pop();
                      },
                    );
                    break;
                }
                return null;
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1,
                );
              },
              itemCount: 1),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('我的收藏'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear_all),
            onPressed: clearAll,
          )
        ],
        elevation: 0,
      ),
      body: _favorites == null || _favorites.isEmpty
          ? GestureDetector(
              onTap: get,
              child: Container(
                child: Center(
                  child: Text('无数据，点击刷新'),
                ),
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 2.0, color: CustomTheme.theme.backgroundColor),
                ),
              ),
            )
          : RefreshIndicator(
              onRefresh: get,
              child: ListView.separated(
                itemCount: _favorites.length,
                separatorBuilder: (content, index) {
                  return Divider(
                    height: 1.0,
                  );
                },
                itemBuilder: (content, i) {
                  Music item = _favorites[i];
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
                      icon: Icon(Icons.more_vert),
                      onPressed: () {
                        more(i);
                      },
                    ),
                    onTap: () {
                      MusicPlayer.setList(_favorites);
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
