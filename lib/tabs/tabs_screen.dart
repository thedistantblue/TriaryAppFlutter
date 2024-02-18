import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:triary_app/data/data_base/base_power_training_repository.dart';
import 'package:triary_app/tabs/cardio_training_list.dart';
import 'package:triary_app/tabs/power_training_list.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var powerTrainingRepository =
      Provider.of<BasePowerTrainingRepository>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.fitness_center),
                text: "Power training",
              ),
              Tab(
                icon: Icon(Icons.directions_run),
                text: "Cardio training",
              )
            ],
          ),
          title: const Text("TriaryApp"),
        ),
        body: TabBarView(
          children: [
            PowerTrainingList(powerTrainingRepository),
            CardioTrainingList(),
          ],
        ),
      ),
    );
  }
}
