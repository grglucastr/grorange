import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/controllers/user_controller.dart';
import 'package:grorange/models/ModelProvider.dart';
import 'package:grorange/pages/home_page.dart';
import 'package:grorange/pages/login_page.dart';

import 'amplifyconfiguration.dart';

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
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    try {

      final datastorePlugin = AmplifyDataStore(modelProvider: ModelProvider.instance);
      await Amplify.addPlugin(datastorePlugin);

      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);

      // call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyconfig);

    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }
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
