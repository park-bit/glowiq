import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../utils/file_storage.dart';

class UserDataProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void saveUserData({
    required String name,
    required int age,
    required double weight,
    required double height,
    required String skinColor,
    required List<String> goals,
  }) {
    _user = UserModel(
      name: name,
      age: age,
      weight: weight,
      height: height,
      skinColor: skinColor,
      goals: goals,
    );
    FileStorage.saveUserData(_user!.toMap());
    notifyListeners();
  }

  Future<void> loadUserData() async {
    final data = await FileStorage.loadUserData();
    if (data != null) {
      _user = UserModel.fromMap(data);
      notifyListeners();
    }
  }
}