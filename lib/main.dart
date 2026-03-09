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
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFF48CAA0),
          onPrimary: Colors.black54,
          secondary: Color(0xFF48CAA0),
          onSecondary: Colors.black54,
          error: Colors.red,
          onError: Colors.black54,
          background: Color(0xFF212730),
          onBackground: Colors.grey,
          surface: Color(0xFF373D46),
          onSurface: Colors.grey,
          surfaceTint: Color(0xFF373D46),
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
