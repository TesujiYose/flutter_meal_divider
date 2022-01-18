import 'package:flutter/material.dart';

import 'package:flutter_meal_divider/providers/meal_container.dart';
import 'package:provider/provider.dart';

class AddContainerScreen extends StatefulWidget {
  AddContainerScreen({Key? key}) : super(key: key);

  @override
  State<AddContainerScreen> createState() => _AddContainerScreenState();
}

class _AddContainerScreenState extends State<AddContainerScreen> {
  final List<Color> _colors = [
    Colors.white,
    Colors.green,
    Colors.red,
    Colors.amber,
    Colors.purple,
    Colors.yellow,
  ];

  Color _choosedColor = Colors.white;

  TimeOfDay _selectedTime = TimeOfDay(hour: 10, minute: 00);

  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final containerData = Provider.of<MContainers>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add container'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'Name'),
            ),
            DropdownButton<Color>(
              value: _choosedColor,
              onChanged: (newValue) {
                if (newValue != null) {
                  print(newValue);
                  _choosedColor = newValue;
                }
                setState(() {});
              },
              items: _colors.map<DropdownMenuItem<Color>>((Color e) {
                return DropdownMenuItem(
                  child: Text(e.toString()),
                  value: e,
                );
              }).toList(),
            ),
            TextButton(
                onPressed: () async {
                  final _pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    initialEntryMode: TimePickerEntryMode.input,
                  );
                  if (_pickedTime != null) _selectedTime = _pickedTime;
                  // print(selectedTime);
                },
                child: Text('Select time')),
            TextButton(
              onPressed: () {
                containerData.addContainer(
                  MealContainer(
                    id: DateTime.now().toString(),
                    name: _nameController.text,
                    scheduledTime: _selectedTime,
                    storage: [],
                    color: _choosedColor,
                  ),
                );
                Navigator.pop(context);
              },
              child: Text('Submit!'),
            ),
          ],
        ),
      ),
    );
  }
}
