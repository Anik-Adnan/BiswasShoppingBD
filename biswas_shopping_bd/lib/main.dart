import 'package:biswas_shopping_bd/screens/auth-ui/splash-screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'screens/user-panel/main-screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}