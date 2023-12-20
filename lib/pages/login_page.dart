import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/controllers/user_controller.dart';
import 'package:grorange/pages/login_logout_intermediate_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.amber,
                    maxRadius: 60,
                  ),
                  Text(
                    "Grorange",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'RobotoMono',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 190,
              child: Column(
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () => _redirectToPleaseWait(context),
                      child: const Text("Login with Google"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: false,
                    child: SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("Login with Facebook"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _redirectToPleaseWait(BuildContext context) {
    UserController userController = Get.find();
    userController.loginInProgress = true;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginLogoutIntermediatePage()),
      (route) => false,
    );
  }
}
