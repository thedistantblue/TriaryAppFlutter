import 'package:flutter/material.dart';

class NameDescriptionWidget extends StatelessWidget {
  final _nameEditingController = TextEditingController();
  final _descriptionEditingController = TextEditingController();
  final Function _createFunction;

  String get _name => _nameEditingController.text;

  String get _description => _descriptionEditingController.text;

  NameDescriptionWidget({super.key, required createFunction})
      : _createFunction = createFunction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
              controller: _nameEditingController,
            ),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description',
              ),
              controller: _descriptionEditingController,
            ),
            const Spacer(),
            FilledButton(
              onPressed: () {
                _createFunction((_name, _description));
                Navigator.of(context).pop();
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }
}
