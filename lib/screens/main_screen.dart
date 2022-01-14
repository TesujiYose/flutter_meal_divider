import 'package:flutter/material.dart';
import 'package:flutter_meal_divider/providers/meal_container.dart';
import 'package:flutter_meal_divider/screens/add_container_screen.dart';
import 'package:flutter_meal_divider/screens/container_view_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final containerData = Provider.of<MContainers>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddContainerScreen(),
                  ),
                );
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (ctx, i) {
          MealContainer _box = containerData.items[i];
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContainerViewScreen(_box.id),
                ),
              );
            },
            title: Text(_box.name),
            subtitle: Text('id is ${_box.id}'),
          );
        },
        itemCount: containerData.items.length,
      ),
    );
  }
}
