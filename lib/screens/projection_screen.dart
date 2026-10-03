import 'package:flutter/material.dart';

import '../navigation/screen_routes.dart';
import 'native_screen_page.dart';

class ProjectionScreen extends StatelessWidget {
  const ProjectionScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      const NativeScreenPage(route: ScreenRoute.projection);
}
