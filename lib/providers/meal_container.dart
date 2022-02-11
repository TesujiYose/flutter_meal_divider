import 'package:flutter/material.dart';
import 'package:flutter_meal_divider/providers/meal_box.dart';
import 'package:flutter_meal_divider/providers/summary.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import './meal.dart';

part 'meal_container.g.dart';

@HiveType(typeId: 1)
class MealContainer {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  DateTime scheduledTime;
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
  final List<MealContainer> _items = [];
  final MealBox _mealBox = MealBox();
  late Meal summury;

  List<MealContainer> get items {
    return _mealBox.getItems();
  }

  MealContainer findById(String id) {
    return _mealBox.findById(id);
  }

  Map<String, double> mealsMap(id) {
    double carbohydrate = 0, protein = 0, fat = 0;
    MealContainer _mc = findById(id);
    List<Meal> _storage = _mc.storage;
    for (var meal in _storage) {
      carbohydrate += meal.carbohydrate;
      protein += meal.protein;
      fat += meal.fat;
    }
    return {
      'Carbohydrate': carbohydrate,
      'Protein': protein,
      'Fat': fat,
    };
  }

  void addContainer(MealContainer cnt) {
    _items.add(cnt);
    _mealBox.addContainer(cnt);
    notifyListeners();
  }

  void removeContainer(String id) {
    _items.removeWhere((element) => element.id == id);
    _mealBox.removeContainer(id);
    notifyListeners();
  }

  void addProductToContainer(String id, Meal meal) {
    //_items.firstWhere((element) => element.id == id).storage.add(meal);
    _mealBox.addProductToContainer(id, meal);
    notifyListeners();
  }

  void resetAllContent() {
    _mealBox.resetAllContent();
    notifyListeners();
  }

  Summary getContainerSummary(String id) {
    List<double> _sum = [0, 0, 0, 0, 0];

    MealContainer _mc = findById(id);
    _mc.storage.forEach((e) {
      _sum[0] += e.carbohydrate;
      _sum[1] += e.protein;
      _sum[2] += e.fat;
      _sum[4] += e.weight;
      _sum[3] += e.calories;
    });
    return Summary(_sum[0], _sum[1], _sum[2], _sum[3], _sum[4]);
  }

  Summary getSummary() {
    List<double> _sum = [0, 0, 0, 0, 0];
    for (var e in items) {
      MealContainer _mc = findById(e.id);
      _mc.storage.forEach((e) {
        _sum[0] += e.carbohydrate;
        _sum[1] += e.protein;
        _sum[2] += e.fat;
        _sum[4] += e.weight;
        _sum[3] += e.calories;
      });
    }
    return Summary(_sum[0], _sum[1], _sum[2], _sum[3], _sum[4]);
  }
}
