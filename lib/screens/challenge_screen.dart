import 'package:flutter/material.dart';
import '../models/challenge_model.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({Key? key}) : super(key: key);

  @override
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  List<ChallengeModel> challenges = [
    ChallengeModel(id: "1", title: "10,000 Steps a Day", description: "Walk 10,000 steps every day for a week to earn 50 coins.", reward: "50 coins", startDate: DateTime.now(), endDate: DateTime.now().add(const Duration(days: 7)), participantsIds: []),
    ChallengeModel(id: "2", title: "Marathon Runner", description: "Run a total of 42km in a month to earn a Marathon Badge.", reward: "Marathon Badge", startDate: DateTime.now(), endDate: DateTime.now().add(const Duration(days: 30)), participantsIds: []),
    // Add more challenges here
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Challenges'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: challenges.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(challenges[index].title),
              subtitle: Text(challenges[index].description),
              trailing: Text(challenges[index].reward),
              onTap: () {
                // Handle challenge participation here
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Join Challenge"),
                      content: const Text("このチャレンジに参加しますか？"),
                      actions: <Widget>[
                        TextButton(
                          child: const Text("はい"),
                          onPressed: () {
                            // チャレンジに参加するロジックを追加
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text("いいえ"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
