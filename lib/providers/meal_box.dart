import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:hive/hive.dart';

import 'meal_container.dart';

class MealBox with ChangeNotifier {
  final String _boxName = 'mealBox';

  initBox() async {
    await Hive.openBox(_boxName);
    log('$_boxName opened with ${_boxName.length} entries');
  }

  void addContainer(MealContainer cnt) {
    Hive.box(_boxName).put(cnt.id, cnt);
    notifyListeners();
  }

  void removeContainer(String id) {
    Hive.box(_boxName).delete(id);
  }

  List<MealContainer> getItems() {
    List<MealContainer> _mc = [];
    for (var key in Hive.box(_boxName).keys) {
      _mc.add(Hive.box(_boxName).get(key));
    }
    return _mc;
  }

  MealContainer findById(String id) {
    return Hive.box(_boxName).get(id);
  }
}
