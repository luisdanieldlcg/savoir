import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:savoir/common/theme.dart';

class PulseProgressIndicator extends StatelessWidget {
  const PulseProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitPulse(
        color: AppTheme.primaryColor,
        size: 128,
      ),
    );
  }
}
