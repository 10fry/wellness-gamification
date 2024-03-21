import 'package:flutter/material.dart';
import '../models/community_model.dart';
import '../services/api_service.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  Future<List<CommunityModel>>? communityMembers;

  @override
  void initState() {
    super.initState();
    communityMembers = ApiService().fetchCommunityMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community & Challenges'),
      ),
      body: FutureBuilder<List<CommunityModel>>(
        future: communityMembers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                CommunityModel member = snapshot.data![index];
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(member.friendName),
                  subtitle: Text('Challenges completed: ${member.challengeParticipation}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () {
                      // Navigate to detailed community member screen (not implemented)
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No community members found'));
          }
        },
      ),
    );
  }
}
