import 'package:flutter/material.dart';
import 'package:flutter_meal_divider/providers/meal_container.dart';
import 'package:flutter_meal_divider/screens/add_meal_screen.dart';
import 'package:provider/provider.dart';

class ContainerViewScreen extends StatelessWidget {
  String _id;
  ContainerViewScreen(this._id);

  @override
  Widget build(BuildContext context) {
    final containerData = Provider.of<MContainers>(context);
    MealContainer _mealContainer = containerData.findById(_id);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddMealScreen(_mealContainer.id),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Text(
            'Time of creation is ${_mealContainer.scheduledTime.hour}:${_mealContainer.scheduledTime.minute}',
          ),
          Text(_mealContainer.name),
          Container(
            height: 300,
            color: Colors.amber,
            child: ListView(
              children: [
                ..._mealContainer.storage.map((e) {
                  return ListTile(
                    title: Text(
                        '${e.name} Macros P/F/C ${e.protein}/${e.fat}/${e.carbohydrate}; Cal:${e.calories}'),
                    trailing: Icon(Icons.pie_chart),
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
