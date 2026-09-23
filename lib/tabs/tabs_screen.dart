import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:storage_api/storage_api.dart';
import 'package:triary_app/bloc/power_training_bloc.dart';
import 'package:triary_app/tabs/cardio_training_list.dart';
import 'package:triary_app/tabs/power_training_list.dart';
import 'package:triary_app/l10n/app_localizations.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var powerTrainingRepository =
        Provider.of<BasePowerTrainingRepository>(context, listen: false);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("TriaryApp"),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
              color: const Color(0x2648CAA0),
              borderRadius: BorderRadius.circular(12),
            ),
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor:
                Theme.of(context).colorScheme.onSurfaceVariant,
            dividerColor: Colors.transparent,
            tabs: [
              Tab(
                icon: const Icon(Icons.fitness_center),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(AppLocalizations.of(context)!.powerTraining),
                ),
              ),
              Tab(
                icon: const Icon(Icons.directions_run),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(AppLocalizations.of(context)!.cardioTraining),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BlocProvider(
              create: (context) => PowerTrainingBloc(powerTrainingRepository)
                ..add(PowerTrainingFetched()),
              child: const PowerTrainingList(),
            ),
            CardioTrainingList(),
          ],
        ),
      ),
    );
  }
}
