
class HealthTip {
  final String id;
  final String title;
  final String content;
  final String category;
  final DateTime publishedDate;

  HealthTip({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.publishedDate,
  });

  factory HealthTip.fromJson(Map<String, dynamic> json) {
    return HealthTip(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      category: json['category'] as String,
      publishedDate: DateTime.parse(json['publishedDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'category': category,
      'publishedDate': publishedDate.toIso8601String(),
    };
  }
}
