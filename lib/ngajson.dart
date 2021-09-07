// @dart=2.9
class ngajson {
  Data data;
  String encode;
  int time;

  ngajson({this.data, this.encode, this.time});

  ngajson.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    encode = json['encode'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['encode'] = this.encode;
    data['time'] = this.time;
    return data;
  }
}

class Data {
  CU cCU;
  GLOBAL gGLOBAL;
  String sROWS;
  Map<String, Message0> tTMaps;
  T tT;
  int iTROWS;
  int iTROWSPAGE;
  int iRROWSPAGE;

  Data({this.cCU, this.gGLOBAL, this.sROWS, this.tT, this.iTROWS, this.iTROWSPAGE, this.iRROWSPAGE,});

  Data.fromJson(Map<String, dynamic> json) {
    cCU = json['__CU'] != null ? new CU.fromJson(json['__CU']) : null;
    gGLOBAL = json['__GLOBAL'] != null ? new GLOBAL.fromJson(json['__GLOBAL']) : null;
    sROWS = json['__ROWS'];
    tT = json['__T'] != null ? new T.fromJson(json['__T']) : null;
    iTROWS = json['__T__ROWS'];
    iTROWSPAGE = json['__T__ROWS_PAGE'];
    iRROWSPAGE = json['__R__ROWS_PAGE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cCU != null) {
      data['__CU'] = this.cCU.toJson();
    }
    if (this.gGLOBAL != null) {
      data['__GLOBAL'] = this.gGLOBAL.toJson();
    }
    data['__ROWS'] = this.sROWS;
    if (this.tT != null) {
      data['__T'] = this.tT.toJson();
    }
    data['__T__ROWS'] = this.iTROWS;
    data['__T__ROWS_PAGE'] = this.iTROWSPAGE;
    data['__R__ROWS_PAGE'] = this.iRROWSPAGE;
    return data;
  }
}

class CU {
  int uid;
  int groupBit;
  String admincheck;
  int rvrc;

  CU({this.uid, this.groupBit, this.admincheck, this.rvrc});

  CU.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    groupBit = json['group_bit'];
    admincheck = json['admincheck'];
    rvrc = json['rvrc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['group_bit'] = this.groupBit;
    data['admincheck'] = this.admincheck;
    data['rvrc'] = this.rvrc;
    return data;
  }
}

class GLOBAL {
  String sATTACHBASEVIEW;

  GLOBAL({this.sATTACHBASEVIEW});

  GLOBAL.fromJson(Map<String, dynamic> json) {
    sATTACHBASEVIEW = json['_ATTACH_BASE_VIEW'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_ATTACH_BASE_VIEW'] = this.sATTACHBASEVIEW;
    return data;
  }
}

class T {
  Message0 message0;
  Message0 message1;
  Message0 message2;

  T({this.message0});

  T.fromJson(Map<String, dynamic> json) {
    message0 = json['0'] != null ? new Message0.fromJson(json['0']) : null;
    message1 = json['1'] != null ? new Message0.fromJson(json['1']) : null;
    message2 = json['2'] != null ? new Message0.fromJson(json['2']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message0 != null) {
      data['0'] = this.message0.toJson();
      data['1'] = this.message1.toJson();
      data['2'] = this.message2.toJson();
    }
    return data;
  }
}

class Message0 {
  int tid;
  int fid;
  int quoteFrom;
  String quoteTo;
  String titlefont;
  String topicMisc;
  String author;
  int authorid;
  String subject;
  int type;
  int postdate;
  int lastpost;
  String lastposter;
  int replies;
  int lastmodify;
  int recommend;
  P pP;
  String tpcurl;

  Message0({this.tid, this.fid, this.quoteFrom, this.quoteTo, this.titlefont, this.topicMisc, this.author, this.authorid, this.subject, this.type, this.postdate, this.lastpost, this.lastposter, this.replies, this.lastmodify, this.recommend, this.pP, this.tpcurl});

  Message0.fromJson(Map<String, dynamic> json) {
    tid = json['tid'];
    fid = json['fid'];
    quoteFrom = json['quote_from'];
    quoteTo = json['quote_to'];
    titlefont = json['titlefont'];
    topicMisc = json['topic_misc'];
    author = json['author'];
    authorid = json['authorid'];
    subject = json['subject'];
    type = json['type'];
    postdate = json['postdate'];
    lastpost = json['lastpost'];
    lastposter = json['lastposter'];
    replies = json['replies'];
    lastmodify = json['lastmodify'];
    recommend = json['recommend'];
    pP = json['__P'] != null ? new P.fromJson(json['__P']) : null;
    tpcurl = json['tpcurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tid'] = this.tid;
    data['fid'] = this.fid;
    data['quote_from'] = this.quoteFrom;
    data['quote_to'] = this.quoteTo;
    data['titlefont'] = this.titlefont;
    data['topic_misc'] = this.topicMisc;
    data['author'] = this.author;
    data['authorid'] = this.authorid;
    data['subject'] = this.subject;
    data['type'] = this.type;
    data['postdate'] = this.postdate;
    data['lastpost'] = this.lastpost;
    data['lastposter'] = this.lastposter;
    data['replies'] = this.replies;
    data['lastmodify'] = this.lastmodify;
    data['recommend'] = this.recommend;
    if (this.pP != null) {
      data['__P'] = this.pP.toJson();
    }
    data['tpcurl'] = this.tpcurl;
    return data;
  }
}

class P {
  int tid;
  int pid;
  int authorid;
  int type;
  int postdate;
  String subject;
  String content;

  P({this.tid, this.pid, this.authorid, this.type, this.postdate, this.subject, this.content});

  P.fromJson(Map<String, dynamic> json) {
    tid = json['tid'];
    pid = json['pid'];
    authorid = json['authorid'];
    type = json['type'];
    postdate = json['postdate'];
    subject = json['subject'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tid'] = this.tid;
    data['pid'] = this.pid;
    data['authorid'] = this.authorid;
    data['type'] = this.type;
    data['postdate'] = this.postdate;
    data['subject'] = this.subject;
    data['content'] = this.content;
    return data;
  }
}
