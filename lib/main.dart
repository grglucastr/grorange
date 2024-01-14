import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/amplifyconfiguration.dart';
import 'package:grorange/app.dart';
import 'package:grorange/controllers/app_bar_controller.dart';
import 'package:grorange/controllers/item_controller.dart';
import 'package:grorange/controllers/slot_controller.dart';
import 'package:grorange/controllers/user_controller.dart';
import 'package:grorange/controllers/workspace_controller.dart';
import 'package:grorange/models/ModelProvider.dart';
import 'package:grorange/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Get.put(WorkspaceController());
  Get.put(SlotController());
  Get.put(AppBarController());
  Get.put(ItemController());
  Get.put(UserController());

  await _configureAmplify();
  await _loadLoggedUser();

  runApp(const Grorange());
}

class Grorange extends StatelessWidget {
  const Grorange({super.key});

  @override
  Widget build(BuildContext context) {
    return const App();
  }
}


Future<void> _loadLoggedUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool? logged = prefs.getBool("logged");
  if(logged != null && logged){
    final UserController userController = Get.find();
    final String? rawUserData = prefs.getString("user_data");

    if(rawUserData != null){
      userController.userSignedIn = true;
      userController.user = UserService.fromJson(rawUserData);
      userController.name = userController.user.name;
    }
  }
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