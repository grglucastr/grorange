import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/controllers/user_controller.dart';
import 'package:grorange/pages/home_page.dart';
import 'package:grorange/pages/login_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  final UserController userController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final Widget initialWidget =
        userController.userSignedIn ? const Home() : const LoginPage();

    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: initialWidget,
    );
  }
}
