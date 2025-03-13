import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_data_provider.dart';
import 'goal_details_screen.dart';
import 'workout_logs_screen.dart';
import 'beauty_logs_screen.dart';
import 'meal_logs_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('GlowIQ'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () => _showLogsMenu(context),
          ),
        ],
      ),
      body: userData.user == null || userData.user!.goals.isEmpty
          ? Center(child: Text('No goals found.'))
          : ListView.builder(
        itemCount: userData.user!.goals.length,
        itemBuilder: (context, index) {
          final goal = userData.user!.goals[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Icon(Icons.flag, color: Colors.blue),
              title: Text(goal),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GoalDetailsScreen(goal: goal),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _showQuickActionMenu(context),
      ),
    );
  }

  void _showQuickActionMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.fitness_center, color: Colors.blue),
              title: Text('Add Workout'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/fitness');
              },
            ),
            ListTile(
              leading: Icon(Icons.spa, color: Colors.pink),
              title: Text('Add Beauty Tip'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/beauty');
              },
            ),
            ListTile(
              leading: Icon(Icons.food_bank, color: Colors.green),
              title: Text('Log Meal'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/food');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLogsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.fitness_center),
              title: Text('View Workout Logs'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WorkoutLogsScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.spa),
              title: Text('View Beauty Logs'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BeautyLogsScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.food_bank),
              title: Text('View Meal Logs'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MealLogsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
