import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../utils/file_storage.dart';

class AIService {
  static const String _apiKey = 'YOUR API KEY';
  static const String _apiUrl = 'API URL';

  static Future<String> getRecommendations(UserModel user) async {
    try {
      final workouts = await FileStorage.loadWorkouts();
      final tips = await FileStorage.loadBeautyTips();
      final meals = await FileStorage.loadMeals();

      final prompt = '''
        Provide personalized beauty and fitness recommendations for ${user.name} based on:
        - Age: ${user.age}
        - Weight: ${user.weight} kg
        - Height: ${user.height} cm
        - Skin Color: ${user.skinColor}
        - Goals: ${user.goals.join(', ')}
        - Recent Workouts: ${workouts.take(3).join(', ')}
        - Recent Beauty Tips: ${tips.take(3).join(', ')}
        - Recent Meals: ${meals.take(3).join(', ')}
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
        return 'Failed to load recommendations. Status Code: ${response.statusCode}';
      }
    } catch (e) {
      return 'Failed to load recommendations. Error: $e';
    }
  }
}
