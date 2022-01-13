import 'package:flutter/material.dart';
import 'package:flutter_meal_divider/data/data.dart';
import 'package:flutter_meal_divider/models/meal_container.dart';
import 'package:flutter_meal_divider/screens/add_container_screen.dart';
import 'package:flutter_meal_divider/screens/container_view_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
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
          MealContainer _box = getContainerById(i);
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContainerViewScreen(_box),
                ),
              );
            },
            title: Text(_box.name),
            subtitle: Text('id is ${_box.id}'),
          );
        },
        itemCount: retrieveContainers().length,
      ),
    );
  }
}
