import 'package:flutter/material.dart';

import '../navigation/screen_routes.dart';
import 'native_screen_page.dart';

class ProfileSignedInScreen extends StatelessWidget {
  const ProfileSignedInScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      const NativeScreenPage(route: ScreenRoute.profileSignedIn);
}
