class AlertModel {
  AlertModel({this.title, this.content, this.media});

  AlertModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    media = json['media'];
  }

  String? title;
  String? content;
  String? media;
}
