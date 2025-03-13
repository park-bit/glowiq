import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_data_provider.dart';
import '../utils/file_storage.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  String _selectedSkinColor = 'Fair';
  List<String> _selectedGoals = [];

  final List<String> _goalOptions = [
    'Weight Loss',
    'Muscle Gain',
    'Healthy Skin',
    'General Fitness',
    'Hair Care',
    'Mental Wellness',
    'Stress Reduction',
    'Improved Sleep',
    'Balanced Diet',
    'Anti-Aging',
    'Clear Acne',
    'Increase Energy',
    'Improve Posture',
    'Boost Immunity',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Setup Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(labelText: 'Weight (kg)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _heightController,
                decoration: InputDecoration(labelText: 'Height (cm)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              DropdownButtonFormField<String>(
                value: _selectedSkinColor,
                items: ['Fair', 'Medium', 'Dark']
                    .map((color) => DropdownMenuItem(
                  value: color,
                  child: Text(color),
                ))
                    .toList(),
                onChanged: (value) => setState(() => _selectedSkinColor = value!),
                decoration: InputDecoration(labelText: 'Skin Color'),
              ),
              SizedBox(height: 20),
              Text('Select Goals:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Column(
                children: _goalOptions.map((goal) {
                  return CheckboxListTile(
                    title: Text(goal),
                    value: _selectedGoals.contains(goal),
                    onChanged: (value) => setState(() {
                      if (value!) {
                        _selectedGoals.add(goal);
                      } else {
                        _selectedGoals.remove(goal);
                      }
                    }),
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final userData = Provider.of<UserDataProvider>(context, listen: false);
                    userData.saveUserData(
                      name: _nameController.text,
                      age: int.parse(_ageController.text),
                      weight: double.parse(_weightController.text),
                      height: double.parse(_heightController.text),
                      skinColor: _selectedSkinColor,
                      goals: _selectedGoals,
                    );
                    await FileStorage.setOnboardingCompleted();
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                },
                child: Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}