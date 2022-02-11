import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmptyContainerList extends StatelessWidget {
  const EmptyContainerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: CircleAvatar(
          radius: 175,
          child: FittedBox(
            child: Text(
              'Looks like no container added!',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
