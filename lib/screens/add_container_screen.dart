import 'package:flutter/material.dart';
import 'package:flutter_meal_divider/data/data.dart';
import 'package:flutter_meal_divider/models/meal_container.dart';

class AddContainerScreen extends StatelessWidget {
  AddContainerScreen({Key? key}) : super(key: key);
  TextEditingController _idController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _idController,
              decoration: InputDecoration(hintText: 'Id'),
            ),
            TextFormField(
              controller: _nameController,
            ),
            TextButton(
              onPressed: () {
                addContainer(
                  MealContainer(
                    id: _idController.text,
                    name: _nameController.text,
                    scheduledTime: DateTime.now(),
                    storage: [],
                  ),
                );
                Navigator.pop(context);
              },
              child: Text('Submit!'),
            )
          ],
        ),
      ),
    );
  }
}
