import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Pages/homepge.dart';
import 'core/appTheame.dart';

void main() {
  runApp(
    const ProviderScope( // 👈 wrap the whole app
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EcoPulse',
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}
