import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/calculate_provider.dart';
import 'ui/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider<CalculateProvider>(
      create: (_) => CalculateProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Frontend',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
