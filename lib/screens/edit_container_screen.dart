import 'package:flutter/material.dart';
import 'package:flutter_meal_divider/providers/meal_container.dart';
import 'package:flutter_meal_divider/screens/main_screen.dart';
import 'package:provider/provider.dart';

class EditContainerScreen extends StatefulWidget {
  String id;
  EditContainerScreen(this.id);

  @override
  State<EditContainerScreen> createState() => _EditContainerScreenState();
}

class _EditContainerScreenState extends State<EditContainerScreen> {
  final Map<String, Color> _colorsMap = {
    'White': Colors.white,
    'Green': Colors.green,
    'Red': Colors.red,
    'Amber': Colors.amber,
    'Purple': Colors.purple,
    'Yellow': Colors.yellow,
  };

  final Map<int, String> _colorsMapReverse = {
    Colors.white.value: 'White',
    Colors.green.value: 'Green',
    Colors.red.value: 'Red',
    Colors.amber.value: 'Amber',
    Colors.purple.value: 'Purple',
    Colors.yellow.value: ' Yellow',
  };

  String _choosedColor = 'White';

  TimeOfDay _selectedTime = TimeOfDay(hour: 10, minute: 00);

  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final containerData = Provider.of<MContainers>(context);
    MealContainer _mealContainer = containerData.findById(widget.id);
    _nameController.text = _mealContainer.name;
    _choosedColor = _colorsMapReverse[_mealContainer.color.value] ?? 'White';

    //print(_mealContainer.color.value);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(_mealContainer.color.value),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text('Delete container?'),
                  content: Text('Would you like to delete container?'),
                  actions: [
                    TextButton(
                      child: Text('No'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: Text('Yes'),
                      onPressed: () {
                        containerData.removeContainer(widget.id);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen()),
                            (route) => false);
                      },
                    ),
                  ],
                );
              });
        },
        child: Icon(Icons.delete),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(_mealContainer.id),
            Text(_mealContainer.name),
            Text(_mealContainer.color.toString()),
            Text(_mealContainer.scheduledTime.toString()),
            ..._mealContainer.storage.map((e) => Text(e.name)),
            SizedBox(
              height: 100,
            ),
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
                        _mealContainer.color =
                            _colorsMap[newValue] ?? Colors.white;
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
          ],
        ),
      ),
    );
  }
}
