import 'package:flutter/material.dart';
import 'package:flutter_meal_divider/models/meal_container.dart';

class ContainerViewScreen extends StatelessWidget {
  MealContainer _mealContainer;
  ContainerViewScreen(this._mealContainer);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            'Time of creation is ${_mealContainer.scheduledTime.hour}:${_mealContainer.scheduledTime.minute}',
          ),
          Container(
            height: 300,
            child: ListView(
              children: [
                ..._mealContainer.storage.map((e) {
                  return ListTile(
                    title: Text(e.id),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
