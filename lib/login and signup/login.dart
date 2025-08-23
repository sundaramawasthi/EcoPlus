import 'package:ecopulse/login and signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Pages/reportpage.dart';
import '../core/appTheame.dart';
import '../profile/profile.dart';
import 'auth_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';

  void _login() {
    if (_formKey.currentState!.validate()) {
      ref.read(authProvider.notifier).login(email, password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ReportPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Card(
            elevation: isMobile ? 0 : 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: const EdgeInsets.all(24),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary),
                      onPressed: () {// 👇 Navigate to ReportPage
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ReportPage()),
                        );
                      },
                      child: const Text("Login",
                          style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 24),

                    TextFormField(
                      decoration: const InputDecoration(labelText: "Email"),
                      onChanged: (value) => email = value,
                      validator: (value) => value == null || value.isEmpty
                          ? "Enter email"
                          : null,
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      decoration: const InputDecoration(labelText: "Password"),
                      obscureText: true,
                      onChanged: (value) => password = value,
                      validator: (value) =>
                      value == null || value.length < 6
                          ? "Min 6 characters"
                          : null,
                    ),
                    const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text("Login"),
                      ),
                    ),
                    const SizedBox(height: 16),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SignupPage()),
                        );
                      },
                      child: const Text("Don’t have an account? Sign Up"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
