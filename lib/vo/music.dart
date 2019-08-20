class Music {
  int id;
  String name;
  List<Artists> artists;
  Album album;
  List<String> alia;

  Music({this.id, this.name, this.artists, this.album, this.alia});

  Music.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['artists'] != null) {
      artists = new List<Artists>();
      json['artists'].forEach((v) {
        artists.add(new Artists.fromJson(v));
      });
    }
    if (json['ar'] != null) {
      artists = new List<Artists>();
      json['ar'].forEach((v) {
        artists.add(new Artists.fromJson(v));
      });
    }
    album = json['album'] != null ? new Album.fromJson(json['album']) : null;
    album = json['al'] != null ? new Album.fromJson(json['album']) : album;
    alia = json['alia'] != null ? json['alia'].cast<String>() : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.artists != null) {
      data['artists'] = this.artists.map((v) => v.toJson()).toList();
    }
    if (this.album != null) {
      data['album'] = this.album.toJson();
    }
    data['alia'] = this.alia;
    return data;
  }
}

class Artists {
  int id;
  String name;
  String picUrl;
  int picId;
  String img1v1Url;

  Artists({this.id, this.name, this.picUrl, this.picId, this.img1v1Url});

  Artists.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    picUrl = json['picUrl'];
    picId = json['picId'];
    img1v1Url = json['img1v1Url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['picUrl'] = this.picUrl;
    data['picId'] = this.picId;
    data['img1v1Url'] = this.img1v1Url;
    return data;
  }
}

class Album {
  int id;
  String name;

  Album({this.id, this.name});

  Album.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      id = json['id'];
      name = json['name'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
