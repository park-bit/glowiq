import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_data_provider.dart';
import '../services/ai_service.dart';
import '../services/ai_helper.dart';

class RecommendationsScreen extends StatefulWidget {
  @override
  _RecommendationsScreenState createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  String _recommendation = '';
  bool _isLoading = false;

  Future<void> _fetchRecommendations() async {
    setState(() {
      _isLoading = true;
    });

    final userData = Provider.of<UserDataProvider>(context, listen: false);
    final response = await AIService.getRecommendations(userData.user!);

    setState(() {
      _recommendation = response;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchRecommendations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Recommendations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Text(
            _recommendation,
            style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.bodyMedium?.color),
          ),
        ),
      ),
    );
  }
}
