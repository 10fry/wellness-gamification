import 'dart:convert';
import 'package:cursor_ai_project_web/screens/health_tips_screen.dart';
import 'package:http/http.dart' as http;
import '../models/activity_data_model.dart';
import '../models/goal_model.dart';
import '../models/challenge_model.dart';
import '../models/community_model.dart';

class ApiService {
  final String _baseUrl = 'https://yourapi.com/api';
  final String _apiKey = 'Your_API_Key';

  Future<List<ActivityDataModel>> fetchActivityData(String userId) async {
    return Future.delayed(const Duration(seconds: 1), () => [
      ActivityDataModel(
        userId: userId,
        activityType: 'ランニング',
        activityDate: DateTime.now().subtract(const Duration(days: 1)),
        activityDuration: const Duration(minutes: 30),
        caloriesBurned: 300,
      ),
      ActivityDataModel(
        userId: '2',
        activityType: 'ウォーキング',
        activityDate: DateTime.now().subtract(const Duration(days: 2)),
        activityDuration: const Duration(minutes: 45),
        caloriesBurned: 200,
      ),
    ]);
    final response = await http.get(Uri.parse('$_baseUrl/activity/$userId?apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<ActivityDataModel> activities = body.map((dynamic item) => ActivityDataModel.fromJson(item)).toList();
      return activities;
    } else {
      throw Exception('Failed to load activity data');
    }
  }

  Future<bool> postActivityData(ActivityDataModel activityData) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/activity?apiKey=$_apiKey'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(activityData.toJson()),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to post activity data');
    }
  }

  Future<GoalModel> fetchGoal(String userId) async {
    final response = await http.get(Uri.parse('$_baseUrl/goals/$userId?apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      return GoalModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('目標の読み込みに失敗しました');
    }
  }

  Future<ChallengeModel> fetchChallenge(String challengeId) async {
    final response = await http.get(Uri.parse('$_baseUrl/challenges/$challengeId?apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      return ChallengeModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load challenge');
    }
  }

  Future<List<HealthTipModel>> fetchHealthTips() async {
    final response = await http.get(Uri.parse('$_baseUrl/healthtips?apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<HealthTipModel> tips = body.map((dynamic item) => HealthTipModel.fromJson(item)).toList();
      return tips;
    } else {
      throw Exception('Failed to load health tips');
    }
  }

  Future<List<CommunityModel>> fetchCommunityMembers() async {
    await Future.delayed(Duration(seconds: 1)); // ネットワークリクエストを模倣するために1秒待機
    // 以下は仮のコミュニティメンバーデータを生成して返す例です
    return [
      CommunityModel(
        userId: 'user1',
        friendId: 'friend1',
        challengeId: 'challenge1',
        friendsList: ['friend2', 'friend3'],
        friendName: '友達1', // 必要なパラメーターを追加
        challengeParticipation: {'participating': true},
        leaderboard: {'user1': 100, 'user2': 90},
      ),
      CommunityModel(
        userId: 'user2',
        friendId: 'friend2',
        challengeId: 'challenge2',
        friendsList: ['friend1', 'friend4'],
        friendName: '友達1', // 必要なパラメーターを追加
        challengeParticipation: {'participating': false},
        leaderboard: {'user2': 95, 'user3': 80},
      ),
    ];
    final response = await http.get(Uri.parse('$_baseUrl/community?apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<CommunityModel> members = body.map((dynamic item) => CommunityModel.fromJson(item)).toList();
      return members;
    } else {
      throw Exception('コミュニティメンバーの読み込みに失敗しました');
    }
  }

  Future<bool> setGoal(GoalModel goal) async {
    // 仮のレスポンスを返すためのコード
    await Future.delayed(Duration(seconds: 1)); // ネットワークリクエストを模倣するために1秒待機
    return true; // 常に成功したと仮定してtrueを返す
    final response = await http.post(
      Uri.parse('$_baseUrl/goals?apiKey=$_apiKey'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(goal),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to set goal');
    }
  }

  fetchGoals() async {
    await Future.delayed(Duration(seconds: 1)); // ネットワークリクエストを模倣するために1秒待機
    // 以下は仮のゴールデータを生成して返す例です
    return [
      GoalModel(
        id: '1',
        userId: 'user1',
        type: '歩数',
        currentValue: 5000,
        targetValue: 10000,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(Duration(days: 30)),
      ),
      GoalModel(
        id: '2',
        userId: 'user2',
        type: '水分摂取量',
        currentValue: 1000,
        targetValue: 2000,
        startDate: DateTime.now(),
        endDate: DateTime.now().add(Duration(days: 15)),
      ),
    ];


    final response = await http.get(Uri.parse('$_baseUrl/goals?apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<GoalModel> goals = body.map((dynamic item) => GoalModel.fromJson(item)).cast<GoalModel>().toList();
      return goals;
    } else {
      throw Exception('Failed to load goals');
    }
  }

  deleteGoal(String goalId) async {
    await Future.delayed(Duration(seconds: 1)); // ネットワークリクエストを模倣するために1秒待機
    // この部分は仮のレスポンスを返すコードです
    return true;
    final response = await http.delete(Uri.parse('$_baseUrl/goals/$goalId?apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete goal');
    }
  }

  // Add more methods as needed for other functionalities like community, challenges, etc.
}
