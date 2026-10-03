import 'package:flutter/material.dart';

import '../navigation/screen_routes.dart';
import 'native_screen_page.dart';

class FreedomDashboardScreen extends StatelessWidget {
  const FreedomDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      const NativeScreenPage(route: ScreenRoute.freedomDashboard);
}
