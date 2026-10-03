import 'package:flutter/material.dart';

import '../navigation/screen_routes.dart';
import 'native_screen_page.dart';

class ProfileAppleSignInScreen extends StatelessWidget {
  const ProfileAppleSignInScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      const NativeScreenPage(route: ScreenRoute.profileAppleSignIn);
}
