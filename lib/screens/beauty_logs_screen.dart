import 'package:flutter/material.dart';
import '../utils/file_storage.dart';

class BeautyLogsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Beauty Logs')),
      body: FutureBuilder<List<String>>(
        future: FileStorage.loadBeautyLogs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final logs = snapshot.data ?? [];
          return ListView.builder(
            itemCount: logs.length,
            itemBuilder: (context, index) => ListTile(
              leading: Icon(Icons.spa),
              title: Text(logs[index]),
            ),
          );
        },
      ),
    );
  }
}