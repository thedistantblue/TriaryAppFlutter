import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        child: Center(
          child: Wrap(
            direction: Axis.horizontal,
            runSpacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: AppLocalizations.of(context)!.name,
                ),
                controller: _nameEditingController,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: AppLocalizations.of(context)!.description,
                ),
                controller: _descriptionEditingController,
              ),
              Center(
                child: FilledButton(
                  onPressed: () {
                    _createFunction((_name, _description));
                    Navigator.of(context).pop();
                  },
                  child: Text(AppLocalizations.of(context)!.create),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
