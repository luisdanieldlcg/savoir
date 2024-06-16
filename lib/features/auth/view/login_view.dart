import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/common/widgets/pulse_progress_indicator.dart';
import 'package:savoir/common/widgets/text_input.dart';
import 'package:savoir/features/auth/controller/auth_controller.dart';
import 'package:savoir/features/auth/view/password_reset_view.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _usernameOrEmail = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;
  bool _buttonEnabled = false;

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
            ref: ref,
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
                        "Nombre de usuario o correo",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextInput(
                      controller: _usernameOrEmail,
                      hintText: "Nombre de usuario o correo",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Contraseña",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextInput(
                      controller: _password,
                      hintText: "******",
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value!;
                                });
                              },
                            ),
                            const Text(
                              "Recuérdame",
                              style: TextStyle(
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            openRecoveryModal(context);
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "¿Olvidaste tu contraseña?",
                              style: TextStyle(color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: _buttonEnabled ? () => attemptLogin() : null,
                        child: const Text("Login"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

void openRecoveryModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.75,
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (context) {
      return DefaultTabController(
        length: 1,
        child: Column(
          children: const [
            TabBar(
              labelStyle: TextStyle(
                fontSize: 16,
              ),
              dividerColor: Colors.transparent,
              tabs: [
                Tab(
                  text: "Recuperar contraseña",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  PasswordResetView(),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
