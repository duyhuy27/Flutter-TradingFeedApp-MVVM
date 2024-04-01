class NewsLatestModel {
  int? type;
  String? message;
  List<Data>? data;

  NewsLatestModel({this.type, this.message, this.data});

  NewsLatestModel.fromJson(Map<String, dynamic> json) {
    type = json['Type'];
    message = json['Message'];
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Type'] = this.type;
    data['Message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? guid;
  int? publishedOn;
  String? imageurl;
  String? title;
  String? url;
  String? body;
  String? tags;
  String? lang;
  String? upvotes;
  String? downvotes;
  String? categories;
  SourceInfo? sourceInfo;
  String? source;

  Data(
      {this.id,
      this.guid,
      this.publishedOn,
      this.imageurl,
      this.title,
      this.url,
      this.body,
      this.tags,
      this.lang,
      this.upvotes,
      this.downvotes,
      this.categories,
      this.sourceInfo,
      this.source});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    guid = json['guid'];
    publishedOn = json['published_on'];
    imageurl = json['imageurl'];
    title = json['title'];
    url = json['url'];
    body = json['body'];
    tags = json['tags'];
    lang = json['lang'];
    upvotes = json['upvotes'];
    downvotes = json['downvotes'];
    categories = json['categories'];
    sourceInfo = json['source_info'] != null
        ? new SourceInfo.fromJson(json['source_info'])
        : null;
    source = json['source'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['guid'] = this.guid;
    data['published_on'] = this.publishedOn;
    data['imageurl'] = this.imageurl;
    data['title'] = this.title;
    data['url'] = this.url;
    data['body'] = this.body;
    data['tags'] = this.tags;
    data['lang'] = this.lang;
    data['upvotes'] = this.upvotes;
    data['downvotes'] = this.downvotes;
    data['categories'] = this.categories;
    if (this.sourceInfo != null) {
      data['source_info'] = this.sourceInfo!.toJson();
    }
    data['source'] = this.source;
    return data;
  }
}

class SourceInfo {
  String? name;
  String? img;
  String? lang;

  SourceInfo({this.name, this.img, this.lang});

  SourceInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    img = json['img'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['img'] = this.img;
    data['lang'] = this.lang;
    return data;
  }
}
