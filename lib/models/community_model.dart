
class CommunityModel {
  final String userId;
  final String friendId;
  final String friendName;
  final String challengeId;
  final List<String> friendsList;
  final Map<String, bool> challengeParticipation; // Challenge ID to participation status
  final Map<String, int> leaderboard; // User ID to points

  CommunityModel({
    required this.userId,
    required this.friendId,
    required this.friendName,
    required this.challengeId,
    required this.friendsList,
    required this.challengeParticipation,
    required this.leaderboard,
  });

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
      userId: json['userId'],
      friendName: json['friendName'],
      friendId: json['friendId'],
      challengeId: json['challengeId'],
      friendsList: List<String>.from(json['friendsList']),
      challengeParticipation: Map<String, bool>.from(json['challengeParticipation']),
      leaderboard: Map<String, int>.from(json['leaderboard']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'friendId': friendId,
      'challengeId': challengeId,
      'friendsList': friendsList,
      'challengeParticipation': challengeParticipation,
      'leaderboard': leaderboard,
    };
  }
}
