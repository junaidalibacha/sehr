import 'package:flutter/material.dart';
import 'package:sehr/presentation/index.dart';
import 'package:sehr/presentation/views/bottom_navigation/bottom_nav_view.dart';
import 'package:sehr/presentation/views/customer_views/scanner/scanner_view.dart';
import 'package:sehr/presentation/views/profile/add_bio/add_business_bio_view.dart';
import 'package:sehr/presentation/views/profile/add_bio/add_customer_bio_view.dart';
import 'package:sehr/presentation/views/profile/profile_complete/profile_complete_view.dart';
import 'package:sehr/presentation/views/profile/set_loaction/set_location_view.dart';
import 'package:sehr/presentation/views/profile/upload_photo/upload_profile_photo_view.dart';
import 'package:sehr/presentation/views/profile/verification_code/varification_code_view.dart';

import '../views/auth/auth.dart';
import '../views/splash/splash_view.dart';

class Routes {
  static const String mainRoute = '/mainRoute';
  static const String splashRoute = '/';

  // Auth views
  static const String loginRoute = '/login';
  static const String signUpRoute = '/signUp';
  static const String profileSelectionRoute = '/profileSelection';

  // Profile views
  static const String addCustomerBioRoute = '/addCustomerBio';
  static const String addBusinessBioRoute = '/addBusinessBio';
  static const String photoSelectionRoute = '/photoSelection';
  static const String setLocationRoute = '/setLocation';
  static const String verificationCodeRoute = '/verificationCode';
  static const String profileCompleteRoute = '/profileComplete';

  // Customer Side Views
  static const String customerBottomNavRoute = '/customerBottomNav';
  static const String scannerRoute = '/scanner';
}

class RoutesGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());

      // Auth Routes
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.signUpRoute:
        return MaterialPageRoute(builder: (_) => const SignUpView());
      case Routes.profileSelectionRoute:
        return MaterialPageRoute(builder: (_) => const ProfileSelectionView());

      // Profile Routes
      case Routes.addCustomerBioRoute:
        return MaterialPageRoute(builder: (_) => const AddCustomerBioView());
      case Routes.addBusinessBioRoute:
        return MaterialPageRoute(builder: (_) => const AddBusinessBioView());
      case Routes.photoSelectionRoute:
        return MaterialPageRoute(
            builder: (_) => const UplaodProfilePhotoView());
      case Routes.setLocationRoute:
        return MaterialPageRoute(builder: (_) => const SetLocationView());
      case Routes.verificationCodeRoute:
        return MaterialPageRoute(builder: (_) => const VerificationCodeView());
      case Routes.profileCompleteRoute:
        return MaterialPageRoute(builder: (_) => const ProfileCompleteView());

      // Customer Side Views
      case Routes.customerBottomNavRoute:
        return MaterialPageRoute(builder: (_) => const CustomerBottomNavView());
      case Routes.scannerRoute:
        return MaterialPageRoute(builder: (_) => const ScannerView());
    }
    return _unDefinedRoute();
  }

  static Route<dynamic> _unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(StringManager.undefinedRoute),
        ),
        body: const Center(
          child: Text(StringManager.noRouteFound),
        ),
      ),
    );
  }
}
