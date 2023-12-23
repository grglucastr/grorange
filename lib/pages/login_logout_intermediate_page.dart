import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/components/loading.dart';
import 'package:grorange/controllers/app_bar_controller.dart';
import 'package:grorange/controllers/user_controller.dart';
import 'package:grorange/pages/home_page.dart';
import 'package:grorange/pages/login_page.dart';
import 'package:grorange/services/amplify_auth_service.dart';

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
    UserController controller = Get.find();

    if (controller.loginInProgress) {
      _doSignIn(controller);
    }

    if (controller.logoutInProgress) {
      _doSignOut(controller);
    }
  }

  void _doSignIn(UserController controller) async {
    AmplifyAuthService authService = AmplifyAuthService();
    final SignInResult? result = await authService.socialSignIn();
    if (result != null && result.isSignedIn) {
      controller.loginInProgress = false;

      final List<AuthUserAttribute>? attrs = await authService.fetchCurrentUserAttributes();
      final AuthUserAttribute nameAttr = attrs!.firstWhere((attr) => _findNameAttribute(attr));
      final String fullName = nameAttr.value;
      controller.name = fullName;

      if (context.mounted) {
        AppBarController appBarController = Get.find();
        appBarController.title.value = "Welcome, ${controller.firstName}";
        _redirectToHome(context);
      }
    }
  }

  void _doSignOut(UserController controller) {
    AmplifyAuthService authService = AmplifyAuthService();
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
