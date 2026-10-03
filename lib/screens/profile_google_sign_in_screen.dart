import 'package:flutter/material.dart';

import '../navigation/screen_routes.dart';
import 'native_screen_page.dart';

class ProfileGoogleSignInScreen extends StatelessWidget {
  const ProfileGoogleSignInScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      const NativeScreenPage(route: ScreenRoute.profileGoogleSignIn);
}
