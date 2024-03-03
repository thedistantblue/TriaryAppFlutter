import 'package:flutter/material.dart';

class PtDetailsScreen extends StatelessWidget {
  const PtDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Power training details"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Exercises",
                  style: TextStyle(fontSize: 20),
                ),
                Icon(Icons.arrow_forward_outlined),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sets of exercises",
                  style: TextStyle(fontSize: 20),
                ),
                Icon(Icons.arrow_forward_outlined),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dates",
                  style: TextStyle(fontSize: 20),
                ),
                Icon(Icons.arrow_forward_outlined),
              ],
            )
          ],
        ),
      ),
    );
  }
}
