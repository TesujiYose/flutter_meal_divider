import 'package:flutter/material.dart';
import 'package:flutter_meal_divider/providers/meal.dart';
import 'package:flutter_meal_divider/providers/meal_container.dart';
import 'package:flutter_meal_divider/screens/error_screen.dart';
import 'package:flutter_meal_divider/screens/loading_screen.dart';
import 'package:flutter_meal_divider/screens/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'providers/app_box.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MealAdapter());
  Hive.registerAdapter(MealContainerAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppBox _box = AppBox();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => MContainers(),
        ),
      ],
      child: MaterialApp(
        title: 'Meal Container Divider',
        home: FutureBuilder(
          future: _box.initBox(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.error != null) {
                print(snapshot.error);
                return ErrorScreen();
              } else {
                return MainScreen();
              }
            } else {
              return const LoadingScreen();
            }
          },
        ),
      ),
    );
  }
}
