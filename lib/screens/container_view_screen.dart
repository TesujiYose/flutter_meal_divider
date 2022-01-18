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
        backgroundColor: _mealContainer.color,
        title: Text(_mealContainer.name),
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
      body: ListView(
        children: [
          Card(
            child: Center(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  'Time when to use ${_mealContainer.scheduledTime.hour}:${_mealContainer.scheduledTime.minute}',
                ),
              ),
            ),
          ),
          Container(
            height: 200,
            child: ListTile(
              title: Text('MACROS INFO'),
              trailing: Icon(
                Icons.pie_chart,
                size: 150,
              ),
            ),
          ),
          Center(
            child: Text('Meals:'),
          ),
          ..._mealContainer.storage.map((e) {
            return Card(
              child: ListTile(
                title: Text(
                    '${e.name} Macros P/F/C ${e.protein}/${e.fat}/${e.carbohydrate}; Cal:${e.calories}'),
                trailing: Icon(Icons.pie_chart),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
