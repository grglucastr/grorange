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
        child: Container(
          width: double.maxFinite,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/pantry.jpg"),
              opacity: 0.2,
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
               Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("images/app-logo.png"),
                  const Text(
                    "Grorange",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'RobotoMono',
                    ),
                  ),
                  const Text('Beta v0.0.1'),
                ],
              ),
              SizedBox(
                width: 310,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      height: 70,
                      child: ElevatedButton(
                        onPressed: () => _redirectToPleaseWait(context),
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.orange)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset("images/icons8-google-50.png"),
                            const Text(
                              "Continue with Google",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
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
      ),
    );
  }

  void _redirectToPleaseWait(BuildContext context) {
    UserController userController = Get.find();
    userController.loginInProgress = true;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => const LoginLogoutIntermediatePage()),
      (route) => false,
    );
  }
}
