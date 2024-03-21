class ActivityDataModel {
  final String userId;
  final String activityType;
  final DateTime activityDate;
  final Duration activityDuration;
  final int caloriesBurned;

  ActivityDataModel({
    required this.userId,
    required this.activityType,
    required this.activityDate,
    required this.activityDuration,
    required this.caloriesBurned,
  });

  factory ActivityDataModel.fromJson(Map<String, dynamic> json) {
    return ActivityDataModel(
      userId: json['userId'],
      activityType: json['activityType'],
      activityDate: DateTime.parse(json['activityDate']),
      activityDuration: Duration(minutes: json['activityDuration']),
      caloriesBurned: json['caloriesBurned'],
    );
  }

  String? get type => null;

  get startDate => null;

  get durationInMinutes => null;

  get calories => null;

  Duration? get duration => activityDuration;

  num? get steps => null;

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'activityType': activityType,
      'activityDate': activityDate.toIso8601String(),
      'activityDuration': activityDuration.inMinutes,
      'caloriesBurned': caloriesBurned,
    };
  }
}
