import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:haoting_music/music/netease.dart';
import 'package:haoting_music/util/music_player.dart';
import 'package:haoting_music/vo/music_detail.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class Player extends StatefulWidget {
  final int id;

  Player(this.id);

  @override
  _PlayerState createState() => _PlayerState(this.id);
}

class _PlayerState extends State<Player> {
  int id;
  MusicDetail detail;
  bool playState = false;
  double progress = 0;
  int duration = 0;
  int currentDuration = 0;

  _PlayerState(this.id);

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    // 查询详情
    MusicDetail detail = await Netease.getDetail(id);
    setState(() {
      this.detail = detail;
    });

    if (detail.url == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('暂无版权'),
              actions: <Widget>[
                FlatButton(
                  child: Text('我知道了'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
      return;
    }

    if (id != MusicPlayer.currentId) {
      MusicPlayer.currentId = id;
      await MusicPlayer.audioPlayer
          .setUrl(detail.url.replaceFirst('http://', 'https://'));
    }

    await this.play();
    bindEvent();
  }

  bindEvent() async {
    // 总长度
    duration = await MusicPlayer.audioPlayer.getDuration();

    MusicPlayer.audioPlayer.onAudioPositionChanged.listen((Duration d) async {
      if (d.inMilliseconds >= duration) {
        int nextId = await MusicPlayer.next();
        playNext(nextId);
      } else {
        currentDuration = d.inMilliseconds;
        // TODO 切换页面后监听没有销毁
        setState(() => progress = d.inMilliseconds / duration * 1.0);
      }
    });
  }

  playNext(int id) async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(builder: (context) => Player(id)));
  }

  play() async {
    if (playState) {
      await MusicPlayer.pause();
    } else {
      await MusicPlayer.resume();
    }
    setState(() {
      this.playState = !this.playState;
    });
  }

  Widget body() {
    double width = MediaQuery.of(context).size.width / 5 * 3;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(
            children: <Widget>[
              SizedBox(
                width: width,
                height: width,
                child: CircularProgressIndicator(
                  strokeWidth: 8.0,
                  value: progress,
                  backgroundColor: Colors.white,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(width / 2),
                  child: FadeInImage.assetNetwork(
                    placeholder: "static/images/default-cover.jpg",
                    image: detail.al.picUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 24),
            child: Text(
              detail.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12),
            child: Text(
              detail.ar.map((item) => item.name).toList().join(','),
              style: TextStyle(
                color: Colors.white70,
                fontSize: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return detail == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(detail.al.picUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Opacity(
                  opacity: 0.8,
                  child: Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Share.share(
                                '我正在"好听音乐"听${detail.name}，你也快来听听吧~ ${detail.url}');
                          },
                        ),
                      ],
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      brightness: Brightness.dark,
                    ),
                    body: body(),
                    bottomNavigationBar: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.arrow_downward,
                              size: 27.0,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              launch(detail.url);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.skip_previous,
                              size: 27.0,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              int preId = await MusicPlayer.pre();
                              playNext(preId);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              playState
                                  ? Icons.pause_circle_outline
                                  : Icons.play_circle_outline,
                              size: 36.0,
                              color: Colors.white,
                            ),
                            onPressed: play,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.skip_next,
                              size: 27.0,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              int nextId = await MusicPlayer.next();
                              playNext(nextId);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.fast_forward,
                              size: 27.0,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              // 快进5秒
                              int target = currentDuration + 5000;
                              if (target >= duration) {
                                int nextId = await MusicPlayer.next();
                                playNext(nextId);
                              } else {
                                MusicPlayer.seek(target);
                              }
                            },
                          ),
                        ],
                      ),
                      height: 200,
                    ),
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
            ],
          );
  }
}
