import 'package:flutter/material.dart';
import 'package:flutter_get_locale/main_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter get locale',
      supportedLocales: [
        Locale('en', ''),
        Locale('es', ''),
        Locale('fr', ''),
        Locale('pt', ''),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: MainScreen(),
    );
  }
}
