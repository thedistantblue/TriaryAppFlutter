import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            child: Text(AppLocalizations.of(context)!.offlineUsage),
            onPressed: () {
              _navigateToTabsScreen(context);
            },
          ),
          const Divider(),
          FilledButton(
            child: Text(AppLocalizations.of(context)!.onlineUsage),
            onPressed: () {
              _navigateToLoginScreen(context);
            },
          )
        ],
      ),
    );
  }

  void _navigateToTabsScreen(BuildContext context) {
    Navigator.of(context).pushNamed("/tabs");
  }

  void _navigateToLoginScreen(BuildContext context) {
    Navigator.of(context).pushNamed("/login");
  }
}
