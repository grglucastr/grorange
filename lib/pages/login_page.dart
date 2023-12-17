import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/controllers/user_controller.dart';
import 'package:grorange/pages/home_page.dart';
import 'package:grorange/services/amplify_auth_service.dart';

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
                      onPressed: () {
                        AmplifyAuthService authService = AmplifyAuthService();
                        authService.socialSignIn().then((value) {
                          safePrint('social sign in callback: $value');

                          if (value?.nextStep.signInStep ==
                              AuthSignInStep.done) {
                            UserController userController = Get.find();
                            if (userController.userSignedIn) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const Home()), (route) => false,
                              );
                            }
                            safePrint(
                                'User signed in? ${userController.userSignedIn}');
                          }
                        });
                      },
                      child: const Text("Login with Google"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text("Login with Facebook"),
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
}
