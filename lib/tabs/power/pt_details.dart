import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PtDetailsScreen extends StatelessWidget {
  const PtDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.powerTrainingDetails),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.exercises,
                  style: const TextStyle(fontSize: 20),
                ),
                const Icon(Icons.arrow_forward_outlined),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.exercisesSets,
                  style: const TextStyle(fontSize: 20),
                ),
                const Icon(Icons.arrow_forward_outlined),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.dates,
                  style: const TextStyle(fontSize: 20),
                ),
                const Icon(Icons.arrow_forward_outlined),
              ],
            )
          ],
        ),
      ),
    );
  }
}
