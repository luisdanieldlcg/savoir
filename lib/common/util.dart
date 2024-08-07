import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:quickalert/quickalert.dart';
import 'package:savoir/common/constants.dart';
import 'package:savoir/common/logger.dart';
import 'package:savoir/common/providers.dart';

import 'package:savoir/common/theme.dart';
import 'package:savoir/features/auth/model/user_model.dart';
import 'package:savoir/features/auth/repository/auth_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class _Utils {}

final _logger = AppLogger.getLogger(_Utils);

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
  final String? stackTrace;
  static final Logger _logger = AppLogger.getLogger(ErrorScreen);

  const ErrorScreen({
    super.key,
    required this.error,
    this.stackTrace,
  });

  @override
  Widget build(BuildContext context) {
    _logger.e('Error: $error');
    if (stackTrace != null) {
      _logger.e('Stack Trace: $stackTrace');
    }
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
  final user = ref.watch(userProvider);
  if (user == null) {
    ref.read(authRepositoryProvider).logOut();
  }
  return user;
}

String formatDate(DateTime time) {
  const String separator = "/";
  return "${time.day}$separator${time.month}$separator${time.year}";
}

Future<File?> pickGaleryImage() async {
  try {
    _logger.i("Attempting to pick image from gallery");
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result != null) {
      _logger.i("Image picked from gallery: ${result.path}");
      return File(result.path);
    }
  } catch (e) {
    _logger.e("Error picking image from gallery: $e");
  }
  return null;
}

String photoFromReferenceGoogleAPI(String photoReference) {
  return "https://places.googleapis.com/v1/$photoReference/media?key=$kGoogleApiTestKey&maxWidthPx=400";
}

Widget title(String title) {
  return Text(
    title,
    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  );
}

void launchExternalApp(String url) async {
  try {
    _logger.i("Launching external app with url: $url");
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
      _logger.i("External app launched successfully");
    }
  } catch (e) {
    _logger.e("Error launching external app: $e");
  }
}
