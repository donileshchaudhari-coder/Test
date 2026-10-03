enum ScreenRoute {
  splash('/splash'),
  freedomEmpty('/freedom-empty'),
  addNumbers('/add-numbers'),
  freedomDashboard('/freedom-dashboard'),
  freedomSummary('/freedom-summary'),
  freedomDetails('/freedom-details'),
  projection('/projection'),
  journey('/journey'),
  cashFlow('/cash-flow'),
  categoryDetail('/category-detail'),
  assets('/assets'),
  savingsAllocation('/savings-allocation'),
  coach('/coach'),
  profile('/profile'),
  profileSettings('/profile-settings'),
  profileSignedIn('/profile-signed-in'),
  profileAppleSignIn('/profile-apple-sign-in'),
  profileGoogleSignIn('/profile-google-sign-in');

  const ScreenRoute(this.path);

  final String path;
}
