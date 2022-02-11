import 'package:hive/hive.dart';

part 'meal.g.dart';

@HiveType(typeId: 0)
class Meal {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double carbohydrate;
  @HiveField(3)
  final double protein;
  @HiveField(4)
  final double fat;
  @HiveField(5)
  final double weight;
  @HiveField(6)
  final double calories;

  Meal({
    required this.id,
    required this.name,
    required this.carbohydrate,
    required this.protein,
    required this.fat,
    required this.weight,
    required this.calories,
  });

  Map<String, double> toMap() {
    return {
      'Carbohydrate': carbohydrate,
      'Protein': protein,
      'Fat': fat,
    };
  }
}
