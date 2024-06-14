import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/features/auth/view/login_view.dart';
import 'package:savoir/firebase_options.dart';
import 'package:savoir/features/onboarding/onboarding.dart';
import 'package:savoir/router.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Savoir',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(  ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(
            color: AppTheme.labelTextColor,
            fontStyle: FontStyle.italic,
            fontSize: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        colorScheme: const ColorScheme.light(
          primary: AppTheme.primaryColor,
        ),
        useMaterial3: true,
      ),
      home: const Onboarding(),
      onGenerateRoute: AppRouter.generateRoutes,
    );
  }
}
