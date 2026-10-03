import 'package:flutter/material.dart';

import '../navigation/screen_routes.dart';
import 'native_screen_page.dart';

class AssetsScreen extends StatelessWidget {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      const NativeScreenPage(route: ScreenRoute.assets);
}
