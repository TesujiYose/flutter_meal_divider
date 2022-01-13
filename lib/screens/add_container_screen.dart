import 'package:flutter/material.dart';

class AddContainerScreen extends StatelessWidget {
  const AddContainerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextFormField(),
          TextFormField(),
          TextFormField(),
        ],
      ),
    );
  }
}
