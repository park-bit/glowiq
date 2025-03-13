import 'package:flutter/material.dart';
import '../utils/file_storage.dart';

class MealLogsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meal Logs')),
      body: FutureBuilder<List<String>>(
        future: FileStorage.loadMealLogs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final logs = snapshot.data ?? [];
          return ListView.builder(
            itemCount: logs.length,
            itemBuilder: (context, index) => ListTile(
              leading: Icon(Icons.fastfood),
              title: Text(logs[index]),
            ),
          );
        },
      ),
    );
  }
}