import 'package:flutter/material.dart';
import '../utils/file_storage.dart';

class WorkoutLogsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workout Logs')),
      body: FutureBuilder<List<String>>(
        future: FileStorage.loadWorkoutLogs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final logs = snapshot.data ?? [];
          return ListView.builder(
            itemCount: logs.length,
            itemBuilder: (context, index) => ListTile(
              leading: Icon(Icons.fitness_center),
              title: Text(logs[index]),
            ),
          );
        },
      ),
    );
  }
}