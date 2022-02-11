import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_meal_divider/providers/meal_container.dart';
import 'package:flutter_meal_divider/providers/summary.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import 'main_screen.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final containerData = Provider.of<MContainers>(context);
    Summary _containerSummary = containerData.getSummary();
    return Center(
      child: Column(
        children: [
          Text('Raw data:'),
          Container(
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
          Container(
            height: 300,
            child: PieChart(
              dataMap: {
                'Cabohydrates': _containerSummary.carbohydrates,
                'Proteins': _containerSummary.proteins,
                'Fat': _containerSummary.fat
              },
              legendOptions: LegendOptions(
                legendPosition: LegendPosition.bottom,
                showLegendsInRow: true,
              ),
            ),
          ),
          Container(
            height: 50,
            width: 175,
            decoration: BoxDecoration(
              border: Border.all(width: 4, color: Colors.red),
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Text('Are you sure?'),
                        content: Text(
                            'This erase all added meals and reset summary!'),
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
                              containerData.resetAllContent();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainScreen()),
                                  (route) => false);
                            },
                          ),
                        ],
                      );
                    });
              },
              child: Center(
                child: Text(
                  'Start new Day!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    letterSpacing: 1,
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
