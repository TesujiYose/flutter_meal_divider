import './meal.dart';

class MealContainer {
  String id;
  String name;
  DateTime scheduledTime;
  List<Meal> storage;
  MealContainer({
    required this.id,
    required this.name,
    required this.scheduledTime,
    this.storage = const [],
  });
}
