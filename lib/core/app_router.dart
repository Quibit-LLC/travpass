import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:travpass/auth_pages/passenger_login.dart';
import 'package:travpass/auth_pages/conductor_login.dart';
import 'package:travpass/auth_pages/register_page_one.dart';
import 'package:travpass/nav_pages/main_page.dart';
import 'package:travpass/auth_pages/intro.dart';

import 'app_routes.dart';

class AppRouter {
  static const String bootAppPath = '/bootApp';
  static const String onBoardingScreenPath = '/onBoardingScreen';
  static const String passengerLogInPath = '/passengerLogIn';
   static const String conductorLogInPath = '/conductorLogIn';
  static const String signUpPath = '/signUp';
  static const String mainActivityPath = '/mainActivity';

  GoRouter router = GoRouter(initialLocation: bootAppPath, routes: [
    GoRoute(
      name: AppRoutes.onBoardingScreenRoute,
      path: onBoardingScreenPath,
      pageBuilder: (context, state) => const CupertinoPage(
        child: IntroPage(),
      ),
    ),
    GoRoute(
      name: AppRoutes.logInRoute,
      path: conductorLogInPath,
      pageBuilder: (context, state) => const CupertinoPage(
        child: ConductorLoginPage(),
      ),
    ),
     GoRoute(
      name: AppRoutes.passengerLoginRoute,
      path: passengerLogInPath,
      pageBuilder: (context, state) => const CupertinoPage(
        child: PassengerLoginPage(),
      ),
    ),
    GoRoute(
      name: AppRoutes.signUpRoute,
      path: signUpPath,
      pageBuilder: (context, state) => const CupertinoPage(
        child: RegisterFirstPage(),
      ),
    ),
    GoRoute(
      name: AppRoutes.mainActivityRoute,
      path: mainActivityPath,
      pageBuilder: (context, state) => const CupertinoPage(
        child: MainPage(),
      ),
    ),
  ]);
}