import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

void successAlert({
  required BuildContext context,
  required String title,
  required String text,
}) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.success,
    title: title,
    text: text,
  );
}

void errorAlert({
  required BuildContext context,
  required String title,
  required String text,
}) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.error,
    title: title,
    text: text,
  );
}

void alert({
  required BuildContext context,
  required String title,
  required String text,
  required QuickAlertType type,
}) {
  QuickAlert.show(
    context: context,
    animType: QuickAlertAnimType.slideInUp,
    type: type,
    title: title,
    text: text,
  );
}
