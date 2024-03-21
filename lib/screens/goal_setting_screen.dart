import 'package:flutter/material.dart';
import '../models/goal_model.dart';
import '../services/api_service.dart';

class GoalSettingScreen extends StatefulWidget {
  const GoalSettingScreen({Key? key}) : super(key: key);

  @override
  _GoalSettingScreenState createState() => _GoalSettingScreenState();
}

class _GoalSettingScreenState extends State<GoalSettingScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _targetValueController = TextEditingController();
  bool _isLoading = false;
  List<GoalModel>? _existingGoals;

  @override
  void initState() {
    super.initState();
    _fetchExistingGoals();
  }

  void _fetchExistingGoals() async {
    setState(() {
      _isLoading = true;
    });
    _existingGoals = await _apiService.fetchGoals();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _goalController.dispose();
    _targetValueController.dispose();
    super.dispose();
  }

void _setGoal() async {
  if (_goalController.text.isEmpty || _targetValueController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('目標と目標値を入力してください')),
    );
    return;
  }

  _isLoading = true;
  GoalModel goal = GoalModel(
    id: UniqueKey().toString(),
    userId: 'currentUser',
    type: _goalController.text,
    currentValue: 0,
    targetValue: int.parse(_targetValueController.text),
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(days: 30)),
  );

  bool result = await _apiService.setGoal(goal);

  if (result) {
    _fetchExistingGoals();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('目標が正常に設定されました')),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('目標の設定に失敗しました')),
    );
  }

  setState(() {
    _isLoading = false;
  });
}

void _deleteGoal(String goalId) async {
  final bool confirmDelete = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('目標を削除'),
        content: const Text('この目標を削除してもよろしいですか？'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('削除'),
          ),
        ],
      );
    },
  ) ?? false;

  if (!confirmDelete) return;

  setState(() {
    _isLoading = true;
  });

  bool result = await _apiService.deleteGoal(goalId);

  if (result) {
    _fetchExistingGoals();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('目標が正常に削除されました')),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('目標の削除に失敗しました')),
    );
  }

  setState(() {
    _isLoading = false;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('目標を設定'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: _goalController,
                    decoration: const InputDecoration(
                      labelText: '目標を入力してください（例：10000歩）',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _targetValueController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: '目標値を入力してください',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _setGoal,
                    child: const Text('目標を設定'),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _existingGoals?.length ?? 0,
                      itemBuilder: (context, index) {
                        final goal = _existingGoals![index];
                        return ListTile(
                          title: Text(goal.type),
                          subtitle: Text('目標値: ${goal.targetValue}、現在の値: ${goal.currentValue}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteGoal(goal.id),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
