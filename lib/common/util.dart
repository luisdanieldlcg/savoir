import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:savoir/common/theme.dart';

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
