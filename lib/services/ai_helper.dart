import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';

class AIHelper {
  static final _storage = FlutterSecureStorage();

  static Future<String> getRecommendations(UserModel user) async {
    final deepSeekKey = await _storage.read(key: 'deepseek_api_key');
    final openAiKey = await _storage.read(key: 'openai_api_key');

    // Prioritize DeepSeek if both keys exist
    if (deepSeekKey != null) {
      return _getDeepSeekRecommendations(user, deepSeekKey);
    } else if (openAiKey != null) {
      return _getChatGPTRecommendations(user, openAiKey);
    } else {
      return 'Please connect an AI service in your profile.';
    }
  }

  static Future<String> _getDeepSeekRecommendations(UserModel user, String apiKey) async {
    final prompt = _buildPrompt(user);
    const url = 'https://api.deepseek.com/v1/chat/completions';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'deepseek-chat',
        'messages': [
          {'role': 'user', 'content': prompt},
        ],
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['choices'][0]['message']['content'];
    } else {
      return 'Error: ${response.statusCode}';
    }
  }

  static Future<String> _getChatGPTRecommendations(UserModel user, String apiKey) async {
    final prompt = _buildPrompt(user);
    const url = 'https://api.openai.com/v1/chat/completions';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'user', 'content': prompt},
        ],
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['choices'][0]['message']['content'];
    } else {
      return 'Error: ${response.statusCode}';
    }
  }

  static String _buildPrompt(UserModel user) {
    return '''
      Provide personalized beauty and fitness recommendations for ${user.name} based on:
      - Age: ${user.age}
      - Weight: ${user.weight} kg
      - Height: ${user.height} cm
      - Skin Color: ${user.skinColor}
      - Goals: ${user.goals.join(', ')}
      Use bullet points and keep it under 200 words.
    ''';
  }
}