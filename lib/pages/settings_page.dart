import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/components/page_app_bar.dart';
import 'package:grorange/controllers/user_controller.dart';
import 'package:grorange/pages/login_page.dart';
import 'package:grorange/services/amplify_auth_service.dart';

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
    final UserController userController = Get.find();
    final List<ListTile> options = List.empty(growable: true);

    ListTile changePassword = const ListTile(
      title: Text('Change Password'),
    );

    ListTile logout =  ListTile(
      title: const Text('Logout'),
      textColor: Colors.white,
      tileColor: Colors.red,
      onTap: (){
        AmplifyAuthService amplifyService = AmplifyAuthService();
        amplifyService.signOut().then((value){
          if(!userController.userSignedIn){
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (BuildContext cont) => const LoginPage()),
                    (route) => false);
          }
        });
      },
    );

    options.add(changePassword);
    options.add(logout);
    return options;
  }
}
