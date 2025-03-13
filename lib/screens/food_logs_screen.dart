import 'package:flutter/material.dart';
import '../utils/file_storage.dart';

class FoodLogsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Food Logs')),
      body: FutureBuilder<List<String>>(
        future: FileStorage.loadMeals(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          final meals = snapshot.data ?? [];
          return ListView.builder(
            itemCount: meals.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(meals[index]),
              );
            },
          );
        },
      ),
    );
  }
}