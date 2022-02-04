import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AppBox with ChangeNotifier {
  final String _boxName = 'appBox';
  List _ids = [];

  initBox() async {
    print('open');
    var box = await Hive.openBox(_boxName);
    if (!box.containsKey('ids')) {
      box.put('ids', []);
    }
    getIds();
    print('init done');
  }

  void addId(String id) async {
    var box = Hive.box(_boxName);
    _ids = box.get('ids');
    _ids.add(id);
    box.put('ids', _ids);
  }

  void getIds() async {
    var box = Hive.box(_boxName);
    _ids = await box.get('ids');
    print(_ids);
    print(_ids.length);
    notifyListeners();
  }
}
