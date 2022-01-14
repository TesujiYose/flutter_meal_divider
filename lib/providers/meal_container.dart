import 'package:flutter/material.dart';

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
