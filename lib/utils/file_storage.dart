import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class FileStorage {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/user_data.json');
  }

  static Future<void> saveUserData(Map<String, dynamic> data) async {
    final file = await _localFile;
    await file.writeAsString(jsonEncode(data));
  }

  static Future<Map<String, dynamic>?> loadUserData() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        return jsonDecode(contents);
      }
    } catch (e) {
      print("Error loading user data: $e");
    }
    return null;
  }

  static Future<void> setOnboardingCompleted() async {
    final file = await _localFile;
    await file.writeAsString(jsonEncode({'onboardingCompleted': true}));
  }

  static Future<bool> isOnboardingCompleted() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        final data = jsonDecode(contents);
        return data['onboardingCompleted'] ?? false;
      }
    } catch (e) {
      print("Error checking onboarding status: $e");
    }
    return false;
  }

  static Future<File> get _workoutFile async {
    final path = await _localPath;
    return File('$path/workout_logs.json');
  }

  static Future<void> saveWorkout(String workout) async {
    final file = await _workoutFile;
    final List<String> workouts = await loadWorkouts();
    workouts.add(workout);
    await file.writeAsString(jsonEncode(workouts));
  }

  static Future<List<String>> loadWorkouts() async {
    try {
      final file = await _workoutFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        return List<String>.from(jsonDecode(contents));
      }
    } catch (e) {
      print("Error loading workouts: $e");
    }
    return [];
  }

  static Future<File> get _beautyFile async {
    final path = await _localPath;
    return File('$path/beauty_logs.json');
  }

  static Future<void> saveBeautyTip(String tip) async {
    final file = await _beautyFile;
    final List<String> tips = await loadBeautyTips();
    tips.add(tip);
    await file.writeAsString(jsonEncode(tips));
  }

  static Future<List<String>> loadBeautyTips() async {
    try {
      final file = await _beautyFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        return List<String>.from(jsonDecode(contents));
      }
    } catch (e) {
      print("Error loading beauty tips: $e");
    }
    return [];
  }

  static Future<File> get _mealFile async {
    final path = await _localPath;
    return File('$path/meal_logs.json');
  }

  static Future<void> saveMeal(String meal) async {
    final file = await _mealFile;
    final List<String> meals = await loadMeals();
    meals.add(meal);
    await file.writeAsString(jsonEncode(meals));
  }

  static Future<List<String>> loadMeals() async {
    try {
      final file = await _mealFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        return List<String>.from(jsonDecode(contents));
      }
    } catch (e) {
      print("Error loading meals: $e");
    }
    return [];
  }

  static Future<File> get _workoutLogsFile async {
    final path = await _localPath;
    return File('$path/workout_logs.json');
  }

  static Future<File> get _beautyLogsFile async {
    final path = await _localPath;
    return File('$path/beauty_logs.json');
  }

  static Future<File> get _mealLogsFile async {
    final path = await _localPath;
    return File('$path/meal_logs.json');
  }

  // Save logs
  static Future<void> saveWorkoutLog(String workout) async {
    final file = await _workoutLogsFile;
    final logs = await loadWorkoutLogs();
    logs.add(workout);
    await file.writeAsString(jsonEncode(logs));
  }

  static Future<void> saveBeautyLog(String tip) async {
    final file = await _beautyLogsFile;
    final logs = await loadBeautyLogs();
    logs.add(tip);
    await file.writeAsString(jsonEncode(logs));
  }

  static Future<void> saveMealLog(String meal) async {
    final file = await _mealLogsFile;
    final logs = await loadMealLogs();
    logs.add(meal);
    await file.writeAsString(jsonEncode(logs));
  }

  // Load logs
  static Future<List<String>> loadWorkoutLogs() async {
    try {
      final file = await _workoutLogsFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        return List<String>.from(jsonDecode(contents));
      }
    } catch (e) {
      print("Error loading workout logs: $e");
    }
    return [];
  }

  static Future<List<String>> loadBeautyLogs() async {
    try {
      final file = await _beautyLogsFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        return List<String>.from(jsonDecode(contents));
      }
    } catch (e) {
      print("Error loading beauty logs: $e");
    }
    return [];
  }

  static Future<List<String>> loadMealLogs() async {
    try {
      final file = await _mealLogsFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        return List<String>.from(jsonDecode(contents));
      }
    } catch (e) {
      print("Error loading meal logs: $e");
    }
    return [];
  }
}
