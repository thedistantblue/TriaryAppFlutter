import 'package:flutter/material.dart';
import 'package:triary_app/tabs/cardio_training_list.dart';
import 'package:triary_app/tabs/power_training_list.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        body: const TabBarView(
          children: [
            PowerTrainingList(),
            CardioTrainingList(),
          ],
        ),
      ),
    );
  }
}
