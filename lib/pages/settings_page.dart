import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/components/page_app_bar.dart';
import 'package:grorange/controllers/user_controller.dart';
import 'package:grorange/pages/login_logout_intermediate_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    List<ListTile> options = getOptions(context);

    return Scaffold(
        appBar: const PageAppBar(title: 'Settings',),
        body: ListView.separated(
          itemBuilder: (context, index) => options[index],
          separatorBuilder: (context, index) => const Divider(),
          itemCount: options.length,
        ));
  }

  List<ListTile> getOptions(BuildContext context) {
    final List<ListTile> options = List.empty(growable: true);

    ListTile logout =  ListTile(
      title: const Text('Logout'),
      textColor: Colors.white,
      tileColor: Colors.red,
      onTap: () => _redirectToPleaseWait(context),
    );

    options.add(logout);
    return options;
  }

  void _redirectToPleaseWait(BuildContext context) {
    UserController userController = Get.find();
    userController.logoutInProgress = true;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginLogoutIntermediatePage()),
          (route) => false,
    );
  }
}
