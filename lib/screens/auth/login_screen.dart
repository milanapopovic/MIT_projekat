import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/auth_state.dart'; 

class LoginScreen extends StatefulWidget {
  final VoidCallback onDone;
  final VoidCallback onBack;

  const LoginScreen({
    super.key,
    required this.onDone,
    required this.onBack,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unesi email")),
      );
      return;
    }

    context.read<AuthState>().login(email);

    widget.onDone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: widget.onBack,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Welcome back",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _handleLogin, 
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
