import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/controllers/app_bar_controller.dart';
import 'package:grorange/controllers/slot_controller.dart';
import 'package:grorange/controllers/workspace_controller.dart';
import 'package:grorange/pages/home_page.dart';

void main() {
  final WorkspaceController wkController = Get.put(WorkspaceController());
  final SlotController slotController = Get.put(SlotController());
  final AppBarController appBarController = Get.put(AppBarController());

  runApp(const Grorange());
}

class Grorange extends StatelessWidget {
  const Grorange({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const Home(),
    );
  }
}
