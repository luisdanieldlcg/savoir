import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:savoir/common/widgets/pulse_progress_indicator.dart';
import 'package:savoir/common/widgets/text_input.dart';
import 'package:savoir/features/auth/controller/auth_controller.dart';
import 'package:savoir/router.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _usernameOrEmail = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameOrEmail.dispose();
    _password.dispose();
    super.dispose();
  }

  void attemptLogin() {
    if (_formKey.currentState!.validate()) {
      ref.read(authControllerProvider.notifier).logInUser(
            context: context,
            email: _usernameOrEmail.text,
            password: _password.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      body: isLoading
          ? const PulseProgressIndicator()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Welcome back",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    const SizedBox(height: 30),
                    TextInput(
                      controller: _usernameOrEmail,
                      hintText: "Username or Email",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextInput(
                      controller: _password,
                      hintText: "Password",
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, AppRouter.signup);
                          },
                          child: const Text("Sign up"),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, AppRouter.passwordReset);
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () => attemptLogin(),
                      child: const Text("Login"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
