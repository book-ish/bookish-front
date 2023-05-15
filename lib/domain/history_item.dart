class HistoryItem {

  String title;
  String memo;
  List<String> hashTags;
  String imageUrl;

  HistoryItem(this.title, this.memo, this.hashTags, this.imageUrl);

  factory HistoryItem.fromJson(dynamic json) {
    return HistoryItem(json['title'] as String, json['memo'] as String, List.from(json['hashtags']), json['imageUrl'] as String);
  }
}