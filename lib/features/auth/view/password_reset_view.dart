import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/common/widgets/pulse_progress_indicator.dart';
import 'package:savoir/common/widgets/text_input.dart';
import 'package:savoir/features/auth/controller/auth_controller.dart';

class PasswordResetView extends ConsumerStatefulWidget {
  const PasswordResetView({super.key});

  @override
  ConsumerState<PasswordResetView> createState() => _PasswordResetViewState();
}

class _PasswordResetViewState extends ConsumerState<PasswordResetView> {
  final _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _buttonEnabled = false;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  void attemptReset() {
    if (_formKey.currentState!.validate()) {
      ref.read(authControllerProvider.notifier).resetPassword(
            context: context,
            email: _email.text,
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
                onChanged: () {
                  setState(() {
                    _buttonEnabled = _formKey.currentState!.validate();
                  });
                },
                key: _formKey,
                child: Column(
                  children: [
                    const Spacer(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Correo electrónico',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextInput(
                      controller: _email,
                      hintText: 'example@email.com',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: _buttonEnabled ? () => attemptReset() : null,
                        child: const Text("Restablecer contraseña"),
                      ),
                    ),
                    const SizedBox(height: 24),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        "Ir hacia atrás",
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                    const Spacer(flex: 3),
                  ],
                ),
              ),
            ),
    );
  }
}
