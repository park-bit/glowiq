import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../providers/user_data_provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;
  late String _selectedSkinColor;
  late List<String> _selectedGoals;
  bool _isEditing = false;
  final _storage = FlutterSecureStorage();
  String? _deepSeekApiKey;
  String? _openAiApiKey;

  @override
  void initState() {
    super.initState();
    _loadApiKeys();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = Provider.of<UserDataProvider>(context, listen: false).user;

      setState(() {
        _nameController = TextEditingController(text: user?.name ?? '');
        _ageController = TextEditingController(text: user?.age?.toString() ?? '');
        _weightController = TextEditingController(text: user?.weight?.toString() ?? '');
        _heightController = TextEditingController(text: user?.height?.toString() ?? '');
        _selectedSkinColor = user?.skinColor ?? 'Fair';
        _selectedGoals = List<String>.from(user?.goals ?? []);
      });
    });
  }

  Future<void> _loadApiKeys() async {
    _deepSeekApiKey = await _storage.read(key: 'deepseek_api_key');
    _openAiApiKey = await _storage.read(key: 'openai_api_key');
    setState(() {});
  }

  Future<void> _saveApiKey(String key, String value) async {
    await _storage.write(key: key, value: value);
    await _loadApiKeys();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              if (_isEditing) {
                userData.saveUserData(
                  name: _nameController.text,
                  age: int.tryParse(_ageController.text) ?? 0,
                  weight: double.tryParse(_weightController.text) ?? 0.0,
                  height: double.tryParse(_heightController.text) ?? 0.0,
                  skinColor: _selectedSkinColor,
                  goals: _selectedGoals,
                );
              }
              setState(() => _isEditing = !_isEditing);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 60),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                enabled: _isEditing,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: _ageController,
                enabled: _isEditing,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Age'),
              ),
              TextFormField(
                controller: _weightController,
                enabled: _isEditing,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Weight (kg)'),
              ),
              TextFormField(
                controller: _heightController,
                enabled: _isEditing,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Height (cm)'),
              ),
              DropdownButtonFormField<String>(
                value: _selectedSkinColor,
                items: ['Fair', 'Medium', 'Dark']
                    .map((color) => DropdownMenuItem(
                  value: color,
                  child: Text(color),
                ))
                    .toList(),
                onChanged: _isEditing
                    ? (value) => setState(() => _selectedSkinColor = value!)
                    : null,
                decoration: InputDecoration(labelText: 'Skin Color'),
              ),
              SizedBox(height: 20),
              Text(
                'Goals',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Wrap(
                spacing: 8.0,
                children: [
                  _buildGoalChip('Lose Weight'),
                  _buildGoalChip('Gain Muscle'),
                  _buildGoalChip('Improve Stamina'),
                  _buildGoalChip('Healthy Eating'),
                ],
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.account_tree),
                title: Text('Connect AI Services'),
                subtitle: Text('Link your DeepSeek or ChatGPT account'),
              ),
              _buildApiKeyField(
                label: 'DeepSeek API Key',
                value: _deepSeekApiKey,
                onSave: (value) => _saveApiKey('deepseek_api_key', value),
              ),
              _buildApiKeyField(
                label: 'ChatGPT API Key',
                value: _openAiApiKey,
                onSave: (value) => _saveApiKey('openai_api_key', value),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoalChip(String goal) {
    final isSelected = _selectedGoals.contains(goal);
    return FilterChip(
      label: Text(goal),
      selected: isSelected,
      onSelected: _isEditing
          ? (selected) {
        setState(() {
          if (selected) {
            _selectedGoals.add(goal);
          } else {
            _selectedGoals.remove(goal);
          }
        });
      }
          : null,
    );
  }

  Widget _buildApiKeyField({
    required String label,
    required String? value,
    required Function(String) onSave,
  }) {
    final controller = TextEditingController(text: value);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              obscureText: true,
              decoration: InputDecoration(
                labelText: label,
                border: OutlineInputBorder(),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => onSave(controller.text),
          ),
        ],
      ),
    );
  }
}
