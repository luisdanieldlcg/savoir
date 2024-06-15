import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/widgets/pulse_progress_indicator.dart';
import 'package:savoir/common/widgets/text_input.dart';
import 'package:savoir/features/auth/controller/auth_controller.dart';

class SignupView extends ConsumerStatefulWidget {
  const SignupView({super.key});

  @override
  ConsumerState<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends ConsumerState<SignupView> {
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _buttonEnabled = false;

  @override
  void dispose() {
    _username.dispose();
    _email.dispose();
    _phoneNumber.dispose();
    _password.dispose();
    super.dispose();
  }

  void attemptSignup() {
    if (_formKey.currentState!.validate()) {
      ref.read(authControllerProvider.notifier).createUser(
            context: context,
            email: _email.text,
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
              child: SafeArea(
                child: Form(
                  key: _formKey,
                  onChanged: () {
                    setState(() {
                      _buttonEnabled = _formKey.currentState!.validate();
                    });
                  },
                  child: ListView(
                    children: [
                      const SizedBox(height: 44),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Nombre de usuario",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextInput(
                        controller: _username,
                        hintText: "Luis De La Cruz",
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Correo electrónico",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextInput(
                        controller: _email,
                        hintText: "ejemplo@email.com",
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Teléfono",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextInput(
                        controller: _phoneNumber,
                        hintText: "123-456-7890",
                        obscureText: true,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Contraseña",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextInput(
                        controller: _password,
                        hintText: "Ingrese al menos 6 caracteres",
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: _buttonEnabled ? () => attemptSignup() : null,
                          child: const Text("Registrarse"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
