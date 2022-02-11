import 'package:flutter/material.dart';
import 'package:flutter_meal_divider/providers/meal.dart';
import 'package:flutter_meal_divider/providers/meal_box.dart';
import 'package:flutter_meal_divider/providers/meal_container.dart';
import 'package:flutter_meal_divider/screens/error_screen.dart';
import 'package:flutter_meal_divider/screens/loading_screen.dart';
import 'package:flutter_meal_divider/screens/main_screen.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MealAdapter());
  Hive.registerAdapter(MealContainerAdapter());
  Hive.registerAdapter(ColorAdapter());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final MealBox _box = MealBox();
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
                return const ErrorScreen();
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
