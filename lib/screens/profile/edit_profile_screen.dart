import 'package:fashion_app1/auth/auth_state.dart';
import 'package:fashion_app1/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  final String initialName;
  final String initialEmail;

  const EditProfileScreen({
    super.key,
    required this.initialName,
    required this.initialEmail,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameCtrl;
  late final TextEditingController _emailCtrl;

  final TextEditingController _currentPassCtrl = TextEditingController();
  final TextEditingController _newPassCtrl = TextEditingController();
  final TextEditingController _confirmPassCtrl = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.initialName);
    _emailCtrl = TextEditingController(text: widget.initialEmail);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _currentPassCtrl.dispose();
    _newPassCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  void _showDemoSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _onSaveProfile() {
    final newName = _nameCtrl.text.trim();

    if (newName.isEmpty) {
      _showDemoSnack('Name cannot be empty.');
      return;
    }

    context.read<AuthState>().updateName(newName);
    _showDemoSnack('Profile updated.');
    Navigator.pop(context);
  }

  void _onChangePassword() {
    final current = _currentPassCtrl.text;
    final newPass = _newPassCtrl.text;
    final confirm = _confirmPassCtrl.text;

    if (current.isEmpty || newPass.isEmpty || confirm.isEmpty) {
      _showDemoSnack('Please fill in all password fields.');
      return;
    }
    if (newPass.length < 6) {
      _showDemoSnack('New password must be at least 6 characters.');
      return;
    }
    if (newPass != confirm) {
      _showDemoSnack('New password and confirmation do not match.');
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password updated successfully')),
    );

    _currentPassCtrl.clear();
    _newPassCtrl.clear();
    _confirmPassCtrl.clear();

    Navigator.pop(context);
  }

  InputDecoration _dec(String label, {Widget? suffix}) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      suffixIcon: suffix,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit profile'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.brandLine),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(10),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Profile info',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _nameCtrl,
                    decoration: _dec('Full name'),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _emailCtrl,
                    readOnly: true,
                    decoration: _dec('Email'),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 46,
                    child: ElevatedButton(
                      onPressed: _onSaveProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brand,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Save changes',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.brandLine),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(10),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Change password',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: _currentPassCtrl,
                    obscureText: _obscureCurrent,
                    decoration: _dec(
                      'Current password',
                      suffix: IconButton(
                        onPressed: () => setState(() => _obscureCurrent = !_obscureCurrent),
                        icon: Icon(_obscureCurrent ? Icons.visibility_off : Icons.visibility),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: _newPassCtrl,
                    obscureText: _obscureNew,
                    decoration: _dec(
                      'New password',
                      suffix: IconButton(
                        onPressed: () => setState(() => _obscureNew = !_obscureNew),
                        icon: Icon(_obscureNew ? Icons.visibility_off : Icons.visibility),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  TextField(
                    controller: _confirmPassCtrl,
                    obscureText: _obscureConfirm,
                    decoration: _dec(
                      'Confirm new password',
                      suffix: IconButton(
                        onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                        icon: Icon(_obscureConfirm ? Icons.visibility_off : Icons.visibility),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  const SizedBox(height: 12),

                  SizedBox(
                    height: 46,
                    child: OutlinedButton(
                      onPressed: _onChangePassword,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.brandSoft,
                        foregroundColor: AppColors.brand,
                        side: BorderSide(color: AppColors.brandBorder),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Update password',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
