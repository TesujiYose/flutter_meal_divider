import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_meal_divider/providers/meal.dart';
import 'package:flutter_meal_divider/providers/meal_container.dart';
import 'package:flutter_meal_divider/providers/summary.dart';
import 'package:flutter_meal_divider/screens/add_meal_screen.dart';
import 'package:flutter_meal_divider/screens/edit_container_screen.dart';
import 'package:flutter_meal_divider/screens/meal_view_screen.dart';
import 'package:flutter_meal_divider/widgets/legend_row.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class ContainerViewScreen extends StatelessWidget {
  String _id;
  ContainerViewScreen(this._id);

  List<Color> _colors = [
    Colors.blue[700] ?? Colors.blue,
    Colors.red,
    Colors.green
  ];

  @override
  Widget build(BuildContext context) {
    final containerData = Provider.of<MContainers>(context);
    MealContainer _mealContainer = containerData.findById(_id);
    Summary _containerSummary = containerData.getContainerSummary(_id);

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
                  builder: (context) => EditContainerScreen(_mealContainer.id),
                ),
              );
            },
            icon: Icon(Icons.edit),
          ),
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
            height: 250,
            child: Container(
              width: 300,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    flex: 1,
                    child: PieChart(
                      colorList: _colors,
                      dataMap: containerData.mealsMap(_mealContainer.id),
                      chartValuesOptions: ChartValuesOptions(
                        showChartValuesInPercentage: true,
                      ),
                      legendOptions: LegendOptions(
                        showLegends: false,
                        legendPosition: LegendPosition.bottom,
                        legendShape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Legend:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        LegendRow('Carbohydrate', _colors[0]),
                        SizedBox(height: 8),
                        LegendRow('Protein', _colors[1]),
                        SizedBox(height: 8),
                        LegendRow('Fat', _colors[2]),
                        SizedBox(height: 12),
                        Text(
                          'Summary:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Row(
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
                                  Text('${_containerSummary.carbohydrates}'),
                                  Text('${_containerSummary.proteins}'),
                                  Text('${_containerSummary.fat}'),
                                  Text('${_containerSummary.weight}'),
                                  Text('${_containerSummary.calories}'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Text('Meals:'),
          ),
          if (_mealContainer.storage.length == 0)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddMealScreen(_mealContainer.id),
                  ),
                );
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Looks like no meals find!\n Try adding one!'),
                      Icon(
                        Icons.add,
                        size: 36,
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            ..._mealContainer.storage.map((e) {
              return Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MealViewScreen(
                            e, _mealContainer.id, _mealContainer.color),
                      ),
                    );
                  },
                  title: Text('${e.name}'),
                  trailing: Container(
                    width: 80,
                    child: PieChart(
                      animationDuration: Duration(seconds: 0),
                      dataMap: e.toMap(),
                      legendOptions: LegendOptions(
                        showLegends: false,
                      ),
                      chartValuesOptions: ChartValuesOptions(
                        showChartValueBackground: false,
                        showChartValues: false,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
        ],
      ),
    );
  }
}
