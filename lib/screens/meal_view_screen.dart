import 'package:flutter/material.dart';
import 'package:flutter_meal_divider/providers/meal.dart';
import 'package:flutter_meal_divider/providers/meal_container.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class MealViewScreen extends StatelessWidget {
  Meal meal;
  String containerId;
  Color color;

  MealViewScreen(this.meal, this.containerId, this.color);

  @override
  Widget build(BuildContext context) {
    final containerData = Provider.of<MContainers>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text('Meal Viewer'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text('Delete meal?'),
                      actions: [
                        TextButton(
                          child: Text('No'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        TextButton(
                          child: Text('Yes'),
                          onPressed: () {
                            containerData.deleteMeal(containerId, meal.id);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  });
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Center(
              child: Card(
                elevation: 3,
                color: Colors.grey[300],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    meal.name,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
            PieChart(
              dataMap: {
                'Carbohydrate': meal.carbohydrate,
                'Protein': meal.protein,
                'Fat': meal.fat,
              },
            ),
            Card(
              elevation: 3,
              margin: EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'Macro:',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Carbohydrates:'),
                            Text('Proteins:'),
                            Text('Fats:'),
                            Text('Weight:'),
                            Text('Calories:'),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('${meal.carbohydrate}'),
                            Text('${meal.protein}'),
                            Text('${meal.fat}'),
                            Text('${meal.weight}'),
                            Text('${meal.calories}'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
