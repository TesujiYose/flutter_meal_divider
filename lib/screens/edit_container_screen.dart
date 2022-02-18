import 'package:flutter/material.dart';
import 'package:flutter_meal_divider/providers/meal_container.dart';
import 'package:flutter_meal_divider/screens/main_screen.dart';
import 'package:provider/provider.dart';

class EditContainerScreen extends StatelessWidget {
  String id;
  EditContainerScreen(this.id);
  @override
  Widget build(BuildContext context) {
    final containerData = Provider.of<MContainers>(context);
    MealContainer _mealContainer = containerData.findById(id);
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text('Delete container?'),
                  content: Text('Would you like to delete container?'),
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
                        containerData.removeContainer(id);
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
        child: Icon(Icons.delete),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Text(_mealContainer.id),
          Text(_mealContainer.name),
          Text(_mealContainer.color.toString()),
          Text(_mealContainer.scheduledTime.toString()),
          ..._mealContainer.storage.map((e) => Text(e.name)),
        ],
      ),
    );
  }
}
