import 'package:fashion_app1/auth/auth_state.dart';
import 'package:fashion_app1/constants/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthState(),
      child:  const MyApp()
    ),
   );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: HomeScreen(), // ← jedan screen
    );
  }
}
