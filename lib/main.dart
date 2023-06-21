import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:quotes_app/pages/home.dart';

import 'models/quote.dart';
import 'services/database_service.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(QuoteAdapter());
  await Hive.openBox(DatabaseService.boxName);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
