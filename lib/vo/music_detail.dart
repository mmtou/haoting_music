class MusicDetail {
  String url;
  int br;
  int size;
  String md5;
  int code;
  int expi;
  String type;
  int gain;
  int fee;
  int payed;
  int flag;
  bool canExtend;
  String level;
  String encodeType;
  String name;
  int id;
  int pst;
  int t;
  List<Ar> ar;
  int pop;
  int st;
  String rt;
  int v;
  String cf;
  Al al;
  int dt;
  String cd;
  int no;
  int ftype;
  int djId;
  int copyright;
  int sId;
  int mark;
  int mv;
  int rtype;
  int mst;
  int cp;
  int publishTime;

  MusicDetail(
      {this.url,
      this.br,
      this.size,
      this.md5,
      this.code,
      this.expi,
      this.type,
      this.gain,
      this.fee,
      this.payed,
      this.flag,
      this.canExtend,
      this.level,
      this.encodeType,
      this.name,
      this.id,
      this.pst,
      this.t,
      this.ar,
      this.pop,
      this.st,
      this.rt,
      this.v,
      this.cf,
      this.al,
      this.dt,
      this.cd,
      this.no,
      this.ftype,
      this.djId,
      this.copyright,
      this.sId,
      this.mark,
      this.mv,
      this.rtype,
      this.mst,
      this.cp,
      this.publishTime});

  MusicDetail.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    br = json['br'];
    size = json['size'];
    md5 = json['md5'];
    code = json['code'];
    expi = json['expi'];
    type = json['type'];
    gain = json['gain'];
    fee = json['fee'];
    payed = json['payed'];
    flag = json['flag'];
    canExtend = json['canExtend'];
    level = json['level'];
    encodeType = json['encodeType'];
    name = json['name'];
    id = json['id'];
    pst = json['pst'];
    t = json['t'];
    if (json['ar'] != null) {
      ar = new List<Ar>();
      json['ar'].forEach((v) {
        ar.add(new Ar.fromJson(v));
      });
    }
    pop = json['pop'];
    st = json['st'];
    rt = json['rt'];
    v = json['v'];
    cf = json['cf'];
    al = json['al'] != null ? new Al.fromJson(json['al']) : null;
    dt = json['dt'];
    cd = json['cd'];
    no = json['no'];
    ftype = json['ftype'];
    djId = json['djId'];
    copyright = json['copyright'];
    sId = json['s_id'];
    mark = json['mark'];
    mv = json['mv'];
    rtype = json['rtype'];
    mst = json['mst'];
    cp = json['cp'];
    publishTime = json['publishTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['br'] = this.br;
    data['size'] = this.size;
    data['md5'] = this.md5;
    data['code'] = this.code;
    data['expi'] = this.expi;
    data['type'] = this.type;
    data['gain'] = this.gain;
    data['fee'] = this.fee;
    data['payed'] = this.payed;
    data['flag'] = this.flag;
    data['canExtend'] = this.canExtend;
    data['level'] = this.level;
    data['encodeType'] = this.encodeType;
    data['name'] = this.name;
    data['id'] = this.id;
    data['pst'] = this.pst;
    data['t'] = this.t;
    if (this.ar != null) {
      data['ar'] = this.ar.map((v) => v.toJson()).toList();
    }
    data['pop'] = this.pop;
    data['st'] = this.st;
    data['rt'] = this.rt;
    data['v'] = this.v;
    data['cf'] = this.cf;
    if (this.al != null) {
      data['al'] = this.al.toJson();
    }
    data['dt'] = this.dt;
    data['cd'] = this.cd;
    data['no'] = this.no;
    data['ftype'] = this.ftype;
    data['djId'] = this.djId;
    data['copyright'] = this.copyright;
    data['s_id'] = this.sId;
    data['mark'] = this.mark;
    data['mv'] = this.mv;
    data['rtype'] = this.rtype;
    data['mst'] = this.mst;
    data['cp'] = this.cp;
    data['publishTime'] = this.publishTime;
    return data;
  }
}

class Ar {
  int id;
  String name;

  Ar({this.id, this.name});

  Ar.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Al {
  int id;
  String name;
  String picUrl;
  int pic;

  Al({this.id, this.name, this.picUrl, this.pic});

  Al.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    picUrl = json['picUrl'];
    pic = json['pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['picUrl'] = this.picUrl;
    data['pic'] = this.pic;
    return data;
  }
}
