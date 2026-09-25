import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storage_api/storage_api.dart';
import 'package:storage_local_api/local_storage_api.dart';
import 'package:triary_app/login/login_screen.dart';
import 'package:triary_app/main_screen.dart';
import 'package:triary_app/tabs/power/pt_details.dart';
import 'package:triary_app/tabs/tabs_screen.dart';
import 'package:uuid/uuid.dart';
import 'package:triary_app/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var dataBase = AppDatabase();

  runApp(MultiProvider(
    providers: [
      Provider<Uuid>(create: (_) => const Uuid()),
      Provider<UuidGenerator>(
          create: (context) =>
              UuidGenerator(Provider.of<Uuid>(context, listen: false))),
      Provider<BasePowerTrainingRepository>(
          create: (context) => PowerTrainingRepository(
              Provider.of<UuidGenerator>(context, listen: false), dataBase)),
      Provider<BaseCardioTrainingRepository>(
          create: (context) => CardioTrainingRepository(
              Provider.of<UuidGenerator>(context, listen: false), dataBase)),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TriaryApp',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF131720),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1C2129),
          foregroundColor: Color(0xFFE5E9EF),
          surfaceTintColor: Color(0xFF1C2129),
        ),
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFF48CAA0),
          onPrimary: Color(0xFF0A1F18),
          secondary: Color(0xFF7CC7E8),
          onSecondary: Color(0xFF0A1A24),
          error: Color(0xFFFF6B6B),
          onError: Color(0xFF2B0A0A),
          background: Color(0xFF131720),
          onBackground: Color(0xFFE5E9EF),
          surface: Color(0xFF1C2129),
          onSurface: Color(0xFFE5E9EF),
          surfaceTint: Color(0xFF1C2129),
          onSurfaceVariant: Color(0xFF9AA3AE),
          outline: Color(0xFF3A424E),
          surfaceVariant: Color(0xFF1C2129),
          outlineVariant: Color(0xFF3A424E),
          surfaceContainerLowest: Color(0xFF131720),
          surfaceContainerLow: Color(0xFF1C2129),
          surfaceContainer: Color(0xFF1C2129),
          surfaceContainerHigh: Color(0xFF1C2129),
          surfaceContainerHighest: Color(0xFF1C2129),
          surfaceBright: Color(0xFF1C2129),
          surfaceDim: Color(0xFF131720),
        ),
        useMaterial3: true,
      ),
      routes: {
        "/tabs": (context) => const TabsScreen(),
        "/login": (context) => const LoginScreen(),
        "/pt_details": (context) => const PtDetailsScreen()
      },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const MainScreen(),
    );
  }
}
