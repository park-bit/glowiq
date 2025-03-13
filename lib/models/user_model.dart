class UserModel {
  final String name;
  final int age;
  final double weight;
  final double height;
  final String skinColor;
  final List<String> goals;

  UserModel({
    required this.name,
    required this.age,
    required this.weight,
    required this.height,
    required this.skinColor,
    required this.goals,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'weight': weight,
      'height': height,
      'skinColor': skinColor,
      'goals': goals,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      age: map['age'],
      weight: map['weight'],
      height: map['height'],
      skinColor: map['skinColor'],
      goals: List<String>.from(map['goals']),
    );
  }
}