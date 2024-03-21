
class ChallengeModel {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final List<String> participantsIds;
  final String reward;
  final bool isCompleted;

  ChallengeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.participantsIds,
    required this.reward,
    this.isCompleted = false,
  });

  factory ChallengeModel.fromJson(Map<String, dynamic> json) {
    return ChallengeModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      participantsIds: List<String>.from(json['participantsIds']),
      reward: json['reward'],
      isCompleted: json['isCompleted'],
    );
  }

  Object? get activityType => null;

  Duration? get targetDuration => null;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'participantsIds': participantsIds,
      'reward': reward,
      'isCompleted': isCompleted,
    };
  }
}
