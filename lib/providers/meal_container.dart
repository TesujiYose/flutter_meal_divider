import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import './meal.dart';

part 'meal_container.g.dart';

@HiveType(typeId: 1)
class MealContainer {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  TimeOfDay scheduledTime;
  @HiveField(3)
  List<Meal> storage;
  @HiveField(4)
  Color color;

  MealContainer({
    required this.id,
    required this.name,
    required this.scheduledTime,
    this.storage = const [],
    this.color = Colors.white,
  });
}

class MContainers with ChangeNotifier {
  List<MealContainer> _items = [];

  List<MealContainer> get items {
    return [..._items];
  }

  MealContainer findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void addContainer(MealContainer cnt) {
    _items.add(cnt);
    notifyListeners();
  }

  void removeContainer(String id) {
    _items.removeWhere((element) => element.id == id);
  }

  void addProductToContainer(String id, Meal meal) {
    _items.firstWhere((element) => element.id == id).storage.add(meal);
    notifyListeners();
  }
}
