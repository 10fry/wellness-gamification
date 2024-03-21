
class GoalModel {
  final String id;
  final String userId;
  final String type; // e.g., "steps", "calories", "exercise time"
  final int targetValue; // The target value for the goal (e.g., 10000 steps)
  final int currentValue; // Current progress towards the goal
  final DateTime startDate;
  final DateTime endDate;
  bool get isAchieved => currentValue >= targetValue;

  GoalModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.targetValue,
    required this.currentValue,
    required this.startDate,
    required this.endDate,
  });

  // `activityType` と `targetDuration` の実装を修正して、適切な値を返すようにします。
  // ここでは例として、`activityType` は `String` 型を返し、`targetDuration` は `Duration?` 型を返すようにします。
  // 実際のアプリケーションでは、これらのプロパティに適切な値を設定する必要があります。

  String get activityType => '未定義'; // `null` を返す代わりに、デフォルト値を設定

  Duration? get targetDuration => null; // `Duration?` 型を明示的に指定して、null 許容を示す

  // Convert a GoalModel into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'type': type,
      'targetValue': targetValue,
      'currentValue': currentValue,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }

  // Implement a method to update the current value of the goal
  GoalModel updateProgress(int updatedValue) {
    return GoalModel(
      id: id,
      userId: userId,
      type: type,
      targetValue: targetValue,
      currentValue: updatedValue,
      startDate: startDate,
      endDate: endDate,
    );
  }

  // Create a GoalModel from a map
  factory GoalModel.fromMap(Map<String, dynamic> map) {
    return GoalModel(
      id: map['id'],
      userId: map['userId'],
      type: map['type'],
      targetValue: map['targetValue'],
      currentValue: map['currentValue'],
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
    );
  }

  static Future<GoalModel> fromJson(Map<String, dynamic> json) async {
    return GoalModel(
      id: json['id'],
      userId: json['userId'],
      type: json['type'],
      targetValue: json['targetValue'],
      currentValue: json['currentValue'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }
}
