import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class AIService {
  static const String _apiKey = 'YOUR_HUGGINGFACE_API_KEY';
  static const String _apiUrl = 'https://api-inference.huggingface.co/models/gpt2';

  static Future<String> getRecommendations(UserModel user) async {
    final prompt = '''
      Provide personalized beauty and fitness recommendations for ${user.name} based on:
      - Age: ${user.age}
      - Weight: ${user.weight} kg
      - Height: ${user.height} cm
      - Skin Color: ${user.skinColor}
      - Goals: ${user.goals.join(', ')}
    ''';

    final response = await http.post(
      Uri.parse(_apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        'inputs': prompt,
        'parameters': {'max_length': 200}
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data[0]['generated_text'];
    } else {
      return 'Failed to load recommendations. Please try again.';
    }
  }
}