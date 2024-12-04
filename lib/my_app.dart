import 'package:flutter/material.dart';
import 'package:jazz_up/utilities/constants.dart';

import 'screens/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kColorPrimary),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
