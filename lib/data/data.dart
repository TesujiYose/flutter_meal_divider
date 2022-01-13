import 'package:flutter_meal_divider/models/meal_container.dart';

List<MealContainer> _boxes = [];

void addContainer(MealContainer box) {
  _boxes.add(box);
}

List<MealContainer> retrieveContainers() {
  return _boxes;
}

MealContainer getContainerById(int id) {
  return _boxes[id];
}
