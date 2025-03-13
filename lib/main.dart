import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'screens/onboarding_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/fitness_screen.dart';
import 'screens/food_screen.dart';
import 'screens/goal_details_screen.dart';
import 'providers/user_data_provider.dart';
import 'utils/file_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await requestPermissions();


  final isOnboardingCompleted = await FileStorage.isOnboardingCompleted();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserDataProvider()..loadUserData()),
      ],
      child: GlowIQApp(isOnboardingCompleted: isOnboardingCompleted),
    ),
  );
}


Future<void> requestPermissions() async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.storage,
    Permission.camera,
    Permission.microphone,
    Permission.location,
  ].request();

  statuses.forEach((permission, status) {
    if (status.isDenied || status.isPermanentlyDenied) {
      print("Permission Denied: $permission");
    }
  });
}

class GlowIQApp extends StatelessWidget {
  final bool isOnboardingCompleted;

  const GlowIQApp({required this.isOnboardingCompleted});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GlowIQ',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(color: Colors.black),
      ),
      home: isOnboardingCompleted ? HomeScreen() : OnboardingScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/profile': (context) => ProfileScreen(),
        '/fitness': (context) => FitnessScreen(),
        '/food': (context) => FoodScreen(),
        '/goal_details': (context) => GoalDetailsScreen(goal: "Default Goal"),
      },
    );
  }
}
