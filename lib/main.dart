import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/app.dart';
import 'package:grorange/controllers/app_bar_controller.dart';
import 'package:grorange/controllers/item_controller.dart';
import 'package:grorange/controllers/slot_controller.dart';
import 'package:grorange/controllers/user_controller.dart';
import 'package:grorange/controllers/workspace_controller.dart';
import 'package:grorange/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  Get.put(WorkspaceController());
  Get.put(SlotController());
  Get.put(AppBarController());
  Get.put(ItemController());
  Get.put(UserController());

  await loadLoggedUser();

  runApp(const Grorange());
}

class Grorange extends StatelessWidget {
  const Grorange({super.key});

  @override
  Widget build(BuildContext context) {
    return const App();
  }
}


Future<void> loadLoggedUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool? logged = prefs.getBool("logged");
  if(logged != null && logged){
    final UserController userController = Get.find();
    final String? rawUserData = prefs.getString("user_data");

    if(rawUserData != null){
      safePrint('raw user data: ${rawUserData}');
      userController.userSignedIn = true;
      userController.user = User.fromJson(rawUserData);
      userController.name = userController.user.name;
    }
  }
}