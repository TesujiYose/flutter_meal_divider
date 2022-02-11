import 'package:flutter/material.dart';
import 'package:flutter_meal_divider/providers/meal_box.dart';
import 'package:flutter_meal_divider/providers/meal_container.dart';
import 'package:flutter_meal_divider/screens/add_container_screen.dart';
import 'package:flutter_meal_divider/screens/container_view_screen.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  build(BuildContext context) {
    final containerData = Provider.of<MContainers>(context);
    MealBox _containerBox = MealBox();

    return Scaffold(
      appBar: AppBar(
        title: Text('List of Containers'),
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
          return Card(
            color: _box.color.withOpacity(0.5),
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContainerViewScreen(_box.id),
                    ),
                  );
                },
                title: Text(_box.name),
                subtitle: Text('id is ${_box.scheduledTime}'),
                trailing: Container(
                  height: 25,
                  width: 25,
                  color: _box.color,
                ),
              ),
            ),
          );
        },
        itemCount: containerData.items.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //_containerBox;
        },
      ),
    );
  }
}
