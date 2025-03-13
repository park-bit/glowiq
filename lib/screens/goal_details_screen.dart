import 'package:flutter/material.dart';

class GoalDetailsScreen extends StatelessWidget {
  final String goal;

  const GoalDetailsScreen({required this.goal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(goal)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Customized tips for: $goal', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('1. Tip 1\n2. Tip 2\n3. Tip 3'),
          ],
        ),
      ),
    );
  }
}
