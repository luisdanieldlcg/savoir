import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/firebase_options.dart';
import 'package:savoir/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:savoir/startup.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting();
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
        textTheme: GoogleFonts.interTextTheme(),
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
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: const BorderSide(
              color: AppTheme.primaryColor,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            disabledBackgroundColor: AppTheme.disabledColor,
            disabledForegroundColor: Colors.white,
            backgroundColor: AppTheme.primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.grey,
          selectedItemColor: AppTheme.primaryColor,
        ),
        colorScheme: const ColorScheme.light(
          primary: AppTheme.primaryColor,
        ),
        useMaterial3: true,
      ),
      home: const StartUp(),
      onGenerateRoute: AppRouter.generateRoutes,
    );
  }
}
