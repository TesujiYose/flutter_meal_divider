import 'package:flutter/material.dart';

import 'package:flutter_meal_divider/providers/meal_container.dart';
import 'package:provider/provider.dart';

class AddContainerScreen extends StatelessWidget {
  AddContainerScreen({Key? key}) : super(key: key);

  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final containerData = Provider.of<MContainers>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'Name'),
            ),
            TextButton(
              onPressed: () {
                containerData.addContainer(
                  MealContainer(
                    id: DateTime.now().toString(),
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
