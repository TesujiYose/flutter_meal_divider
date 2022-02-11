import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_meal_divider/providers/meal.dart';

import 'package:hive/hive.dart';

import 'meal_container.dart';

class MealBox with ChangeNotifier {
  final String _boxName = 'mealBox';

  initBox() async {
    await Hive.openBox(_boxName);

    log('$_boxName opened with ${Hive.box(_boxName).keys.length} entries');
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

  void addProductToContainer(String id, Meal meal) {
    MealContainer _cont = findById(id);
    _cont.storage.add(meal);
    addContainer(_cont);
  }

  void getInfo() {
    var box = Hive.box(_boxName);
    log(box.toMap().toString());
  }

  void resetAllContent() {
    var box = Hive.box(_boxName);
    for (String key in box.keys) {
      var _mc = findById(key);
      box.put(
        key,
        MealContainer(
          id: _mc.id,
          name: _mc.name,
          scheduledTime: _mc.scheduledTime,
          storage: [],
          color: _mc.color,
        ),
      );
    }
  }
}
