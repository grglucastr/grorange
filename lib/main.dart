import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/app.dart';
import 'package:grorange/controllers/app_bar_controller.dart';
import 'package:grorange/controllers/item_controller.dart';
import 'package:grorange/controllers/slot_controller.dart';
import 'package:grorange/controllers/workspace_controller.dart';

void main() {
  final WorkspaceController wkController = Get.put(WorkspaceController());
  final SlotController slotController = Get.put(SlotController());
  final AppBarController appBarController = Get.put(AppBarController());
  final ItemController itemController = Get.put(ItemController());

  runApp(const Grorange());
}

class Grorange extends StatelessWidget {
  const Grorange({super.key});

  @override
  Widget build(BuildContext context) {
    return const App();
  }
}
