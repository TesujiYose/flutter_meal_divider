import 'package:flutter/material.dart';
import 'package:flutter_meal_divider/providers/meal_box.dart';
import 'package:flutter_meal_divider/providers/meal_container.dart';
import 'package:flutter_meal_divider/screens/add_container_screen.dart';
import 'package:flutter_meal_divider/screens/container_view_screen.dart';
import 'package:flutter_meal_divider/screens/overview_screen.dart';
import 'package:flutter_meal_divider/screens/summary_screen.dart';
import 'package:flutter_meal_divider/widgets/empty_container_list.dart';
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

    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
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
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text('Containers'),
              ),
              Tab(
                child: Text('Summary'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            OverviewScreen(),
            SummaryScreen(),
          ],
        ),
      ),
    );
  }
}
