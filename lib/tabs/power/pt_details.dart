import 'package:flutter/material.dart';
import 'package:triary_app/l10n/app_localizations.dart';

class PtDetailsScreen extends StatelessWidget {
  const PtDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.powerTrainingDetails),
      ),
      body: ListView(
        children: [
          const Divider(height: 1),
          _DetailTile(
            icon: Icons.fitness_center,
            title: l10n.exercises,
          ),
          const Divider(height: 1),
          _DetailTile(
            icon: Icons.format_list_numbered,
            title: l10n.exercisesSets,
          ),
          const Divider(height: 1),
          _DetailTile(
            icon: Icons.calendar_today,
            title: l10n.dates,
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }
}

class _DetailTile extends StatelessWidget {
  const _DetailTile({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
    );
  }
}
