import 'package:flutter/material.dart';

class WorkoutLogsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Workout Logs')),
      body: ListView(
        children: [
          ListTile(title: Text('Workout 1')),
          ListTile(title: Text('Workout 2')),
          ListTile(title: Text('Workout 3')),
        ],
      ),
    );
  }
}