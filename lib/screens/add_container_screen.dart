import 'package:flutter/material.dart';

import 'package:flutter_meal_divider/providers/meal_container.dart';
import 'package:provider/provider.dart';

import 'package:hive/hive.dart';

class AddContainerScreen extends StatefulWidget {
  AddContainerScreen({Key? key}) : super(key: key);

  @override
  State<AddContainerScreen> createState() => _AddContainerScreenState();
}

class _AddContainerScreenState extends State<AddContainerScreen> {
  final Map<String, Color> _colorsMap = {
    'White': Colors.white,
    'Green': Colors.green,
    'Red': Colors.red,
    'Amber': Colors.amber,
    'Purple': Colors.purple,
    'Yellow': Colors.yellow,
  };

  String _choosedColor = 'White';

  TimeOfDay _selectedTime = TimeOfDay(hour: 10, minute: 00);

  TextEditingController _nameController = TextEditingController();

  @override
  build(BuildContext context) {
    //var boxContainer = await Hive.openBox('containerBox');
    Box<String> _containerBox = Hive.box<String>('containerBox');
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
            Row(
              children: [
                DropdownButton<String>(
                  value: _choosedColor,
                  items:
                      _colorsMap.keys.map<DropdownMenuItem<String>>((String e) {
                    return DropdownMenuItem(
                      child: Row(
                        children: [
                          Text(e.toString()),
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              color: _colorsMap[e],
                              border: Border.all(width: 1),
                            ),
                          )
                        ],
                      ),
                      value: e,
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      if (newValue != null) {
                        _choosedColor = newValue;
                      }
                    });
                  },
                ),
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    color: _colorsMap[_choosedColor],
                  ),
                )
              ],
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () async {
                    final _pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      initialEntryMode: TimePickerEntryMode.input,
                    );
                    setState(() {
                      if (_pickedTime != null) _selectedTime = _pickedTime;
                    });
                    // print(selectedTime);
                  },
                  child: Text('Select time'),
                ),
                Text('${_selectedTime.hour}:${_selectedTime.minute}')
              ],
            ),
            TextButton(
              onPressed: () {
                _containerBox.put('name', _nameController.text);
                containerData.addContainer(
                  MealContainer(
                    id: DateTime.now().toString(),
                    name: _nameController.text,
                    scheduledTime: _selectedTime,
                    storage: [],
                    color: _colorsMap[_choosedColor]!,
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
