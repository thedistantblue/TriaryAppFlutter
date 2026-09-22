import 'package:flutter/material.dart';
import 'package:storage_api/storage_api.dart';
import 'package:triary_app/l10n/app_localizations.dart';

/// Показывает диалог ввода одного текстового значения (название).
/// Возвращает введённую строку или null, если пользователь отменил.
Future<String?> showNameDialog(
  BuildContext context, {
  required String title,
  String? initialValue,
}) async {
  final controller = TextEditingController(text: initialValue ?? '');
  final result = await showDialog<String>(
    context: context,
    builder: (context) {
      final l10n = AppLocalizations.of(context)!;
      return AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: l10n.name,
          ),
          onSubmitted: (value) => Navigator.of(context).pop(value),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(controller.text),
            child: Text(l10n.create),
          ),
        ],
      );
    },
  );
  return result;
}

/// Показывает диалог подтверждения удаления. Возвращает true/false.
Future<bool> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
}) async {
  final l10n = AppLocalizations.of(context)!;
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(l10n.delete),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}

/// Маппит исключение хранилища в локализованное сообщение.
String errorMessage(Object error, AppLocalizations l10n) {
  if (error is EmptyNameException) return l10n.emptyNameError;
  if (error is NameAlreadyExistsException) return l10n.nameExistsError;
  if (error is EntityInUseException) return l10n.entityInUseError;
  return error.toString();
}

/// Форматирует вес: убирает хвостовой ".0" у целых значений.
String formatWeight(double weight) {
  if (weight == weight.roundToDouble()) return weight.round().toString();
  return weight.toString();
}
