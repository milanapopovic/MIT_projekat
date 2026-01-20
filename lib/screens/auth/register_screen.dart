import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../auth/auth_state.dart'; 

class RegisterScreen extends StatefulWidget {
  final VoidCallback onDone;
  final VoidCallback onBack;

  const RegisterScreen({
    super.key,
    required this.onDone,
    required this.onBack,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    final name = _nameController.text.trim(); 
    final email = _emailController.text.trim();
    final pass = _passController.text;
    final confirm = _confirmController.text;

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unesi email")),
      );
      return;
    }
    if (pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unesi lozinku")),
      );
      return;
    }
    if (pass != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lozinke se ne poklapaju")),
      );
      return;
    }

  
    context.read<AuthState>().register(email, name);
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
                "Create account",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),

              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Full name"),
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 16),
              TextField(
                controller: _confirmController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Confirm password"),
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _handleRegister, 
                child: const Text("Create account"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
