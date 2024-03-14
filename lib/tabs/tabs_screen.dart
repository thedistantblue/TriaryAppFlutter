import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:storage_api/storage_api.dart';
import 'package:triary_app/bloc/power_training_bloc.dart';
import 'package:triary_app/tabs/cardio_training_list.dart';
import 'package:triary_app/tabs/power_training_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          bottom: TabBar(
            tabs: [
              Tab(
                icon: const Icon(Icons.fitness_center),
                text: AppLocalizations.of(context)!.powerTraining,
              ),
              Tab(
                icon: const Icon(Icons.directions_run),
                text: AppLocalizations.of(context)!.cardioTraining,
              )
            ],
          ),
          title: const Text("TriaryApp"),
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
