import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_2048/screens/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return const MaterialApp(
      title: '2048',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
