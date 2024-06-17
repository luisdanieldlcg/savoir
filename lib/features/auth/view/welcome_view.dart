// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/widgets/buttons.dart';

import 'package:savoir/features/auth/controller/auth_controller.dart';
import 'package:savoir/features/auth/view/login_view.dart';
import 'package:savoir/features/auth/view/signup_view.dart';

class WelcomeView extends ConsumerWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Stack(
            children: [
              const SizedBox(height: 44),
              Image.asset(
                "assets/images/logo.png",
                width: 400,
                height: 400,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Bienvenido",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  const SizedBox(height: 30),
                  const Text("Antes de disfrutar de los servicios, Por favor regístrese primero",
                      textAlign: TextAlign.center),
                  const SizedBox(height: 35),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    text: "Iniciar Sesión",
                    onPressed: () {
                      openModal(context, 0, ref);
                    },
                  ),
                  const SizedBox(height: 16),
                  SecondaryButton(
                    text: "Crear cuenta",
                    onPressed: () {
                      openModal(context, 1, ref);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openModal(BuildContext context, int initialIndex, WidgetRef ref) {
    showModalBottomSheet(
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) => _AuthModal(initialIndex: initialIndex),
    );
  }
}

class _AuthModal extends ConsumerWidget {
  final int initialIndex;
  const _AuthModal({
    required this.initialIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      initialIndex: initialIndex,
      child: IgnorePointer(
        ignoring: ref.watch(authControllerProvider),
        child: Column(
          children: const [
            TabBar(
              indicatorWeight: 4,
              labelStyle: TextStyle(
                fontSize: 16,
              ),
              dividerColor: Colors.transparent,
              tabs: [
                Tab(
                  text: "Iniciar Sesión",
                ),
                Tab(
                  text: "Crear cuenta",
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  LoginView(),
                  SignupView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
