// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quickalert/quickalert.dart';
import 'package:savoir/common/providers.dart';

import 'package:savoir/common/theme.dart';
import 'package:savoir/features/auth/model/user_model.dart';
import 'package:savoir/features/auth/repository/auth_repository.dart';

void successAlert({
  required BuildContext context,
  required String title,
  required String text,
  VoidCallback? onConfirm,
}) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.success,
    title: title,
    text: text,
    onConfirmBtnTap: onConfirm,
  );
}

void errorAlert({
  required BuildContext context,
  required String title,
  required String text,
  VoidCallback? onConfirm,
}) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.error,
    title: title,
    text: text,
    onConfirmBtnTap: onConfirm,
  );
}

void alert({
  required BuildContext context,
  required String title,
  required String text,
  required QuickAlertType type,
  required VoidCallback onConfirm,
}) {
  QuickAlert.show(
    context: context,
    animType: QuickAlertAnimType.slideInUp,
    type: type,
    title: title,
    text: text,
    confirmBtnColor: AppTheme.primaryColor,
    onConfirmBtnTap: onConfirm,
  );
}

class ErrorScreen extends StatelessWidget {
  final String error;
  const ErrorScreen({
    super.key,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Error: $error',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

UserModel? getUserOrLogOut(WidgetRef ref, context) {
  final user = ref.read(userProvider);
  if (user == null) {
    ref.read(authRepositoryProvider).logOut();
  }
  return user;
}
