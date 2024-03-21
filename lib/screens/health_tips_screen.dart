import 'package:flutter/material.dart';

class HealthTipsScreen extends StatefulWidget {
  const HealthTipsScreen({Key? key}) : super(key: key);

  @override
  _HealthTipsScreenState createState() => _HealthTipsScreenState();
}

class _HealthTipsScreenState extends State<HealthTipsScreen> {
  List<HealthTipModel> healthTips = [
    // Example health tips. Replace with actual data fetched from your CMS or API.
    HealthTipModel(title: "1日に2リットルの水分補給", content: "1日に最低2リットルの水を飲むことで、体を適切に水分補給し、健康を維持します。"),
    HealthTipModel(title: "週に5回の運動", content: "週に5回、各30分以上の身体活動を行うことで、筋力を向上させ、持久力を高めます。"),
    HealthTipModel(title: "1日5食の野菜と果物", content: "1日に5食の野菜と果物を摂取することで、健康的な体重を達成し維持し、慢性疾患のリスクを減らします。"),
    HealthTipModel(title: "毎晩7-8時間の睡眠", content: "毎晩7-8時間の質の良い睡眠を取ることで、心身の健康を保ちます。"),
    HealthTipModel(title: "毎日のストレス解消法の実践", content: "毎日のストレス解消法を実践することで、ストレスを効果的に管理し、健康を維持します。"),
    HealthTipModel(title: "完全な禁煙", content: "喫煙を完全にやめることで、健康を大幅に改善し、多くの病気のリスクを減らします。"),
    HealthTipModel(title: "週に2回以下の節度ある飲酒", content: "週に2回以下の節度ある飲酒を心がけることで、健康に良い影響をもたらし、過度な飲酒のリスクを避けます。"),
    HealthTipModel(title: "週に3回の日光浴", content: "週に3回、各20分の日光浴をすることでビタミンDの生成を助け、健康を促進します。"),
    HealthTipModel(title: "年に2回の健康診断", content: "年に2回の健康診断を受けることで、健康問題を早期に発見し、適切に対処することができます。"),
    HealthTipModel(title: "毎日のポジティブな思考習慣", content: "毎日ポジティブな思考を心がけることで、ストレスを減らし、幸福感を高めます。"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Tips'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: healthTips.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(healthTips[index].title),
              subtitle: Text(healthTips[index].content),
              leading: const Icon(Icons.health_and_safety),
            ),
          );
        },
      ),
    );
  }
}

class HealthTipModel {
  final String title;
  final String content;

  HealthTipModel({required this.title, required this.content});

  static HealthTipModel fromJson(Map<String, dynamic> json) {
    return HealthTipModel(
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }
}
