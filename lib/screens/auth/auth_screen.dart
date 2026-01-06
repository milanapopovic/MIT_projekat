import 'package:fashion_app1/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fashion_app1/auth/auth_state.dart';
import 'package:fashion_app1/screens/auth/login_screen.dart';
import 'package:fashion_app1/screens/auth/register_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool showLogin = false;
  bool showRegister = false;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    // login
    if (showLogin) {
      return LoginScreen(
        onDone: () {
          Navigator.pop(context, true);
        },
        onBack: () {
          setState(() => showLogin = false);
        },
      );
    }

    // register
    if (showRegister) {
      return RegisterScreen(
        onDone: () {
          Navigator.pop(context, true);
        },
        onBack: () {
          setState(() => showRegister = false);
        },
      );
    }

    // main auth
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: h - 48),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Fashion Store",
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 36,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),

                  TextButton(
                    onPressed: () {
                      context.read<AuthState>().logout();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                        (route) => false,
                      );
                    },
                    child: const Text("Continue as guest"),
                  ),

                  const SizedBox(height: 32),

                  ElevatedButton(
                    onPressed: () {
                      setState(() => showLogin = true);
                    },
                    child: const Text("Login"),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {
                      setState(() => showRegister = true);
                    },
                    child: const Text("Register"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
