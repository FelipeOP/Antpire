import 'package:antpire/src/pages/login_page.dart';
import 'package:antpire/src/pages/register_page.dart';
import 'package:antpire/src/pages/start_page.dart';
import 'package:antpire/src/pages/user_account.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:get/route_manager.dart';

class AppRoutes {
  AppRoutes._();

  static final routes = [
    GetPage(
        name: RoutingNameConstants.startPage, page: () => const StartPage()),
    GetPage(
        name: RoutingNameConstants.loginPage, page: () => const LoginPage()),
    GetPage(
        name: RoutingNameConstants.registerPage,
        page: () => const RegisterPage()),
    // GetPage(
    //     name: RoutingNameConstants.completeRegisterPage,
    //     page: () => const CompleteRegisterPage()),
  ];
}

class RoutingNameConstants {
  static String startPage = "/start_page";
  static String loginPage = "/login_page";
  static String registerPage = "/register_page";
  static String completeRegisterPage = "/register_page";
}
