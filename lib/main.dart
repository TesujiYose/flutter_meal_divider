import 'package:flutter/material.dart';
import 'package:flutter_meal_divider/providers/meal.dart';
import 'package:flutter_meal_divider/providers/meal_container.dart';
import 'package:flutter_meal_divider/screens/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => MContainers(),
        ),
      ],
      child: MaterialApp(
        home: MainScreen(),
      ),
    ),
  );
}
