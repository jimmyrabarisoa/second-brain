import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'app_shell.dart';
import 'features/onboarding/presentation/pages/onboarding_screen.dart';

void main() {
  runApp(const ProviderScope(child: SecondBrainApp()));
}

class SecondBrainApp extends StatefulWidget {
  const SecondBrainApp({super.key});

  @override
  State<SecondBrainApp> createState() => _SecondBrainAppState();
}

class _SecondBrainAppState extends State<SecondBrainApp> {
  bool _onboardingDone = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Second Brain',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: _onboardingDone
          ? const AppShell()
          : OnboardingScreen(onDone: () => setState(() => _onboardingDone = true)),
    );
  }
}
