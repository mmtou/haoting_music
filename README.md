> 夜深人静，一杯咖啡，一首民谣，开启了你代码艺术的人生!

### 好听音乐
好听音乐是用Flutter编写的移动端音乐APP。集成网易云音乐、虾米音乐（暂未实现）、QQ音乐（暂未实现）等音乐库，为你提供一个综合的音乐平台。

#### 以图说话
|     |   |
|  ----  | ----  |
| ![](https://github.com/mmtou/haoting_music/demo/首页.png)  | ![](https://github.com/mmtou/haoting_music/demo/主题.png) |
| ![](https://github.com/mmtou/haoting_music/demo/分享.png)  | ![](https://github.com/mmtou/haoting_music/demo/播放.png) |

#### Flutter  
Flutter is Google’s UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase.
> https://flutter.dev/

#### 网易云音乐API  
目前API使用的是 **Binaryify** 提供的NodeJS API。感谢！
> https://binaryify.github.io/NeteaseCloudMusicApi

#### 第三方插件
  1. `dio` 是Flutter中文开发者社区开源的一个强大的Dart Http client插件，支持全局配置、FormData、拦截器、请求取消、文件上传/下载、超时等，好听音乐用 `dio` 请求第三方API。
  
  2. `shared_preferences` 是官方提供的数据持久化插件，好听音乐用 `shared_preferences` 存储收藏的音乐。
  
  3. `audioplayers` 是 一个音频播放的插件，好听音乐用 `audioplayers` 播放音乐。
  
  4. `share` 是官方提供内容分享的插件，好听音乐用 `share` 分享音乐链接。
  
  5. `url_launcher` 是官方提供的调用浏览器开发链接的插件，好听音乐用 `url_launcher` 下载音乐。

  > 另外这里推荐一个更快的Dart Package搜索网站 https://pub.dev/ ，以上插件都可以从这个网站上获取。

#### 关键代码
  1. 安卓沉浸式状态栏
  ![](https://github.com/mmtou/haoting_music/demo/c1.png)

  2. 禁止屏幕旋转
  ![](https://github.com/mmtou/haoting_music/demo/c2.png)

  3. 底部导航栏+切换保留状态
  ![](https://github.com/mmtou/haoting_music/demo/c3.png)

  4. 音乐播放进度
  ![](https://github.com/mmtou/haoting_music/demo/c4.png)
