import 'package:flutter/material.dart';
import '../utils/file_storage.dart';

class BeautyScreen extends StatelessWidget {
  final _beautyTipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Beauty Tip')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _beautyTipController,
              decoration: InputDecoration(
                labelText: 'Beauty Tip',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () async {
                if (_beautyTipController.text.isNotEmpty) {
                  await FileStorage.saveBeautyTip(_beautyTipController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Beauty tip saved!')),
                  );
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}