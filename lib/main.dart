import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/app.dart';
import 'package:grorange/controllers/app_bar_controller.dart';
import 'package:grorange/controllers/item_controller.dart';
import 'package:grorange/controllers/slot_controller.dart';
import 'package:grorange/controllers/user_controller.dart';
import 'package:grorange/controllers/workspace_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  Get.put(WorkspaceController());
  Get.put(SlotController());
  Get.put(AppBarController());
  Get.put(ItemController());
  Get.put(UserController());

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool? logged = prefs.getBool("logged");
  if(logged != null && logged){
    final UserController userController = Get.find();
    userController.userSignedIn = true;
  }

  runApp(const Grorange());
}

class Grorange extends StatelessWidget {
  const Grorange({super.key});

  @override
  Widget build(BuildContext context) {
    return const App();
  }
}
