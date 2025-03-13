import 'package:flutter/material.dart';
import '../utils/file_storage.dart';

class FitnessLogsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fitness Logs')),
      body: FutureBuilder<List<String>>(
        future: FileStorage.loadWorkouts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          final workouts = snapshot.data ?? [];
          return ListView.builder(
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(workouts[index]),
              );
            },
          );
        },
      ),
    );
  }
}