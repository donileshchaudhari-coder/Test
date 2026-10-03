import 'package:flutter/material.dart';

import '../screens/add_numbers_screen.dart';
import '../screens/assets_screen.dart';
import '../screens/cash_flow_screen.dart';
import '../screens/category_detail_screen.dart';
import '../screens/coach_screen.dart';
import '../screens/freedom_dashboard_screen.dart';
import '../screens/freedom_details_screen.dart';
import '../screens/freedom_empty_screen.dart';
import '../screens/freedom_summary_screen.dart';
import '../screens/journey_screen.dart';
import '../screens/profile_apple_sign_in_screen.dart';
import '../screens/profile_google_sign_in_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/profile_settings_screen.dart';
import '../screens/profile_signed_in_screen.dart';
import '../screens/projection_screen.dart';
import '../screens/savings_allocation_screen.dart';
import '../screens/splash_screen.dart';
import 'screen_routes.dart';

final Map<ScreenRoute, WidgetBuilder> screenCatalog = {
  ScreenRoute.splash: (_) => const SplashScreen(),
  ScreenRoute.freedomEmpty: (_) => const FreedomEmptyScreen(),
  ScreenRoute.addNumbers: (_) => const AddNumbersScreen(),
  ScreenRoute.freedomDashboard: (_) => const FreedomDashboardScreen(),
  ScreenRoute.freedomSummary: (_) => const FreedomSummaryScreen(),
  ScreenRoute.freedomDetails: (_) => const FreedomDetailsScreen(),
  ScreenRoute.projection: (_) => const ProjectionScreen(),
  ScreenRoute.journey: (_) => const JourneyScreen(),
  ScreenRoute.cashFlow: (_) => const CashFlowScreen(),
  ScreenRoute.categoryDetail: (_) => const CategoryDetailScreen(),
  ScreenRoute.assets: (_) => const AssetsScreen(),
  ScreenRoute.savingsAllocation: (_) => const SavingsAllocationScreen(),
  ScreenRoute.coach: (_) => const CoachScreen(),
  ScreenRoute.profile: (_) => const ProfileScreen(),
  ScreenRoute.profileSettings: (_) => const ProfileSettingsScreen(),
  ScreenRoute.profileSignedIn: (_) => const ProfileSignedInScreen(),
  ScreenRoute.profileAppleSignIn: (_) => const ProfileAppleSignInScreen(),
  ScreenRoute.profileGoogleSignIn: (_) => const ProfileGoogleSignInScreen(),
};
