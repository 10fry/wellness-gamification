import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/activity_data_model.dart';
import '../services/api_service.dart';

class ActivityTrackingScreen extends StatefulWidget {
  const ActivityTrackingScreen({Key? key}) : super(key: key);

  @override
  _ActivityTrackingScreenState createState() => _ActivityTrackingScreenState();
}

class _ActivityTrackingScreenState extends State<ActivityTrackingScreen> {
  Future<List<ActivityDataModel>>? _activityData;

  @override
  @override
  void initState() {
    super.initState();
    _activityData = Provider.of<ApiService>(context, listen: false).fetchActivityData("1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Tracking'),
      ),
      body: FutureBuilder<List<ActivityDataModel>>(
        future: _activityData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                ActivityDataModel activity = snapshot.data![index];
                return ListTile(
                  title: Text(activity.activityType),
                  subtitle: Text('${activity.activityDate} - Duration: ${activity.activityDuration.inMinutes} mins - Calories: ${activity.caloriesBurned} kcal'),
                  leading: const Icon(Icons.fitness_center),
                );
              },
            );
          } else {
            return const Center(child: Text('No activity data available'));
          }
        },
      ),
    );
  }
}
