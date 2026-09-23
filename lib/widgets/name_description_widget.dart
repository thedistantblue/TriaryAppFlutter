import 'package:flutter/material.dart';
import 'package:triary_app/l10n/app_localizations.dart';

class NameDescriptionWidget extends StatefulWidget {
  const NameDescriptionWidget({
    super.key,
    required this.createFunction,
  });

  final void Function(String name, String description) createFunction;

  @override
  State<NameDescriptionWidget> createState() => _NameDescriptionWidgetState();
}

class _NameDescriptionWidgetState extends State<NameDescriptionWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    widget.createFunction(
      _nameController.text.trim(),
      _descriptionController.text.trim(),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: l10n.name,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.nameRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: l10n.description,
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _submit,
            child: Text(l10n.create),
          ),
        ],
      ),
    );
  }
}
