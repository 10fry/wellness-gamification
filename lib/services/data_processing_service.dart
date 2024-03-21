import '../models/activity_data_model.dart';
import '../models/goal_model.dart';
import '../models/challenge_model.dart';

class DataProcessingService {
  // This method calculates the total calories burned based on the activities logged.
  double calculateTotalCalories(List<ActivityDataModel> activities) {
    double totalCalories = 0;
    for (var activity in activities) {
      totalCalories += activity.caloriesBurned;
    }
    return totalCalories;
  }

  // This method calculates the progress towards a goal for a specific activity type.
  double calculateGoalProgress(List<ActivityDataModel> activities, GoalModel goal) {
    double progress = 0;
    for (var activity in activities) {
      if (activity.activityType == goal.activityType) {
        progress += activity.duration?.inMinutes as double;
      }
    }
    // エラーを修正するために、nullチェックを追加します。
    return progress / (goal.targetDuration?.inMinutes ?? 0) * 100; // パーセンテージとして進捗を返します
  }

  // アクティビティログに基づいてチャレンジが完了したかどうかを確認するメソッドです。
  bool isChallengeCompleted(List<ActivityDataModel> activities, ChallengeModel challenge) {
    double totalDuration = 0;
    for (var activity in activities) {
      if (activity.activityType == challenge.activityType) {
        totalDuration += activity.duration?.inMinutes as double;
      }
    }
    return totalDuration >= challenge.targetDuration!.inMinutes;
  }

  // This method calculates the total steps taken from all activities.
  int calculateTotalSteps(List<ActivityDataModel> activities) {
    int totalSteps = 0;
    for (var activity in activities) {
      totalSteps += activity.steps!.toInt();
    }
    return totalSteps;
  }
}

