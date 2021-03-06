import 'package:flutter/material.dart';
import 'package:flutter_meal_divider/providers/meal_container.dart';
import 'package:provider/provider.dart';

class AddContainerScreen extends StatefulWidget {
  AddContainerScreen({Key? key}) : super(key: key);

  @override
  State<AddContainerScreen> createState() => _AddContainerScreenState();
}

class _AddContainerScreenState extends State<AddContainerScreen> {
  final Map<String, Color> _colorsMap = {
    'Blue': Colors.blue,
    'Green': Colors.green,
    'Red': Colors.red,
    'Amber': Colors.amber,
    'Purple': Colors.purple,
    'Yellow': Colors.yellow,
  };

  String _choosedColor = 'Blue';

  TimeOfDay _selectedTime = TimeOfDay(hour: 10, minute: 00);

  TextEditingController _nameController = TextEditingController();

  @override
  build(BuildContext context) {
    final containerData = Provider.of<MContainers>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add container'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('You Should provide all information!'),
            NameFormField(nameController: _nameController),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _choosedColor,
                  items:
                      _colorsMap.keys.map<DropdownMenuItem<String>>((String e) {
                    return DropdownMenuItem(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(e.toString()),
                          Container(
                            height: 10,
                            width: 10,
                            decoration: BoxDecoration(
                              color: _colorsMap[e],
                              border: Border.all(width: 1),
                            ),
                          ),
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
                Text(MaterialLocalizations.of(context).formatTimeOfDay(
                    _selectedTime,
                    alwaysUse24HourFormat: true))
              ],
            ),
            TextButton(
              onPressed: () {
                final String containerId = DateTime.now().toString();
                final now = DateTime.now();
                var _mealContainer = MealContainer(
                  id: containerId,
                  name: _nameController.text,
                  scheduledTime: DateTime(now.year, now.month, now.day,
                      _selectedTime.hour, _selectedTime.minute),
                  storage: [],
                  color: _colorsMap[_choosedColor]!,
                );

                containerData.addContainer(_mealContainer);

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

class NameFormField extends StatelessWidget {
  const NameFormField({
    Key? key,
    required TextEditingController nameController,
  })  : _nameController = nameController,
        super(key: key);

  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextFormField(
        controller: _nameController,
        decoration: InputDecoration(hintText: 'Name'),
      ),
    );
  }
}
