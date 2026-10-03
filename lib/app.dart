import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'navigation/screen_catalog.dart';
import 'navigation/screen_routes.dart';

class FinancialFreedomApp extends StatelessWidget {
  const FinancialFreedomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Financial Freedom',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        platform: defaultTargetPlatform,
        scaffoldBackgroundColor: const Color(0xFFF2F2F7),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF007AFF),
          primary: const Color(0xFF007AFF),
          secondary: const Color(0xFF1C1C1E),
        ),
      ),
      initialRoute: ScreenRoute.splash.path,
      routes: {
        for (final entry in screenCatalog.entries) entry.key.path: entry.value,
      },
      onUnknownRoute: (_) => MaterialPageRoute<void>(
        builder: (context) =>
            screenCatalog[ScreenRoute.freedomDashboard]!(context),
      ),
    );
  }
}
