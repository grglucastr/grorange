import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/controllers/app_bar_controller.dart';
import 'package:grorange/controllers/user_controller.dart';
import 'package:grorange/database/v2/dao/user_dao.dart';
import 'package:grorange/pages/home_page.dart';
import 'package:grorange/pages/login_page.dart';
import 'package:grorange/services/amplify_auth_service.dart';
import 'package:grorange/services/user_service.dart';
import 'package:grorange/core_widgets/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginLogoutIntermediatePage extends StatefulWidget {
  const LoginLogoutIntermediatePage({super.key});

  @override
  State<LoginLogoutIntermediatePage> createState() =>
      _LoginLogoutIntermediatePageState();
}

class _LoginLogoutIntermediatePageState
    extends State<LoginLogoutIntermediatePage> {
  @override
  void initState() {
    super.initState();
    UserController controller = Get.find();

    if (controller.loginInProgress) {
      _doSignIn(controller);
    }

    if (controller.logoutInProgress) {
      _doSignOut(controller);
    }
  }

  void _doSignIn(UserController controller) async {
    final AmplifyAuthService authService = AmplifyAuthService();
    final SignInResult? result = await authService.socialSignIn();

    if (result == null){
      controller.loginInProgress = false;
      if (context.mounted) {
        _redirectToLoginPage(context);
      }
    }

    if (result != null && result.isSignedIn) {
      controller.loginInProgress = false;

      await _setUserInfoToController(authService, controller);
      await _saveUserToDatabase(controller);
      await _saveLoggedSession(controller);

      if (context.mounted) {
        AppBarController appBarController = Get.find();
        appBarController.title.value = "Welcome, ${controller.firstName}";
        _redirectToHome(context);
      }
    }
  }

  Future<void> _saveLoggedSession(UserController controller) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('logged', true);
    await prefs.setString("user_data", UserService.toJson(controller.user));
  }

  Future<void> _saveUserToDatabase(UserController controller) async {
    await UserDAO().save(controller.user);
  }

  Future<void> _setUserInfoToController(AmplifyAuthService authService, UserController controller) async {
    final List<AuthUserAttribute>? attrs = await authService.fetchCurrentUserAttributes();
    final AuthUserAttribute nameAttr = attrs!.firstWhere((attr) => _findNameAttribute(attr));
    final String fullName = nameAttr.value;
    controller.name = fullName;
  }

  void _doSignOut(UserController controller) async {
    final AmplifyAuthService authService = AmplifyAuthService();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("logged");

    authService.signOut().then((result) {
      controller.logoutInProgress = false;
      if (context.mounted) {
        _redirectToLoginPage(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Loading(),
        ],
      ),
    );
  }

  void _redirectToHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Home()),
      (route) => false,
    );
  }

  void _redirectToLoginPage(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  bool _findNameAttribute(AuthUserAttribute attr) => attr.userAttributeKey.key.toLowerCase().compareTo("name") == 0;
}
