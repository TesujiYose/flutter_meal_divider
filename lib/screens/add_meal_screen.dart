import 'package:flutter/material.dart';
import 'package:flutter_meal_divider/providers/meal.dart';
import 'package:flutter_meal_divider/providers/meal_container.dart';
import 'package:provider/provider.dart';

class AddMealScreen extends StatelessWidget {
  final String id;
  AddMealScreen(this.id);
  TextEditingController _nameController = TextEditingController();
  TextEditingController _carbohydratesController = TextEditingController();
  TextEditingController _proteinController = TextEditingController();
  TextEditingController _fatController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _caloriesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final containerData = Provider.of<MContainers>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add meal'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(hintText: 'Name'),
              ),
              TextFormField(
                controller: _carbohydratesController,
                decoration: InputDecoration(hintText: 'Carbs'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _proteinController,
                decoration: InputDecoration(hintText: 'Protein'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _fatController,
                decoration: InputDecoration(hintText: 'Fat'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(hintText: 'Weight'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _caloriesController,
                decoration: InputDecoration(hintText: 'Calories'),
                keyboardType: TextInputType.number,
              ),
              TextButton(
                  onPressed: () {
                    containerData.addProductToContainer(
                      id,
                      Meal(
                          id: DateTime.now().toString(),
                          name: _nameController.text,
                          carbohydrate:
                              double.tryParse(_carbohydratesController.text)!,
                          protein: double.tryParse(_proteinController.text)!,
                          fat: double.tryParse(_fatController.text)!,
                          weight: double.tryParse(_weightController.text)!,
                          calories: double.tryParse(_caloriesController.text)!),
                    );
                    Navigator.pop(context);
                  },
                  child: Text('Submit!'))
            ],
          ),
        ),
      ),
    );
  }
}
