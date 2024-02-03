import 'package:flutter/material.dart';
import 'package:triary_app/login/login_screen.dart';
import 'package:triary_app/tabs/tabs_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FilledButton(
            child: const Text("Offline usage"),
            onPressed: () {
              _navigateToTabsScreen(context);
            },
          ),
          const Divider(),
          FilledButton(
            child: const Text("Online usage"),
            onPressed: () {
              _navigateToLoginScreen(context);
            },
          )
        ],
      ),
    );
  }

  void _navigateToTabsScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const TabsScreen()));
  }

  void _navigateToLoginScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
