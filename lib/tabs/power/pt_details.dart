import 'package:entity/entity.dart';
import 'package:flutter/material.dart';
import 'package:triary_app/l10n/app_localizations.dart';
import 'package:triary_app/widgets/workout_style.dart';

class PtDetailsScreen extends StatelessWidget {
  const PtDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final training =
        ModalRoute.of(context)!.settings.arguments as PowerTraining;
    return Scaffold(
      appBar: AppBar(
        title: Text(training.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
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
          ),
          SafeArea(
            top: false,
            minimum: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: WorkoutStyle.actionButtonHeight,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pushNamed(
                    '/workout',
                    arguments: training,
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    textStyle: WorkoutStyle.buttonLabel,
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        WorkoutStyle.actionButtonRadius,
                      ),
                    ),
                  ),
                  child: Text(l10n.startTraining),
                ),
              ),
            ),
          ),
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
