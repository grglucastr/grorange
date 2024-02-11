import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/controllers/user_controller.dart';
import 'package:grorange/database/v2/dao/item_dao.dart';
import 'package:grorange/database/v2/dao/slot_dao.dart';
import 'package:grorange/database/v2/dao/workspace_dao.dart';
import 'package:grorange/pages/login_logout_intermediate_page.dart';
import 'package:grorange/services/user_service.dart';
import 'package:grorange/widgets/dialog_delete_confirm.dart';
import 'package:grorange/widgets/page_app_bar.dart';

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
      onTap: () => _redirectToPleaseWait(context),
    );

    ListTile deleteAccount =  ListTile(
      title: const Text('Delete Account'),
      textColor: Colors.white,
      tileColor: Colors.red,
      onTap: () => _showDeleteAccountDialog(),
    );

    options.add(logout);
    options.add(deleteAccount);
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

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogDeleteConfirm(
          title: 'Delete Slot',
          description:
          'Are you sure you want to delete your account? Everything related will be deleted.',
          onConfirm: () => _confirmDeleteAccount(context),
        );
      },
    );
  }

  void _confirmDeleteAccount(BuildContext context) {
    _clearDatabaseContent();
    _deleteUserAccount();
    _redirectToPleaseWait(context);
  }

  void _clearDatabaseContent(){
    UserController userController = Get.find();

    final ItemDAO itemDao = ItemDAO();
    itemDao.deleteAllUserItems(userController.user);

    final SlotDAO slotDao = SlotDAO();
    slotDao.deleteAllUserSlots(userController.user);

    final WorkspaceDAO workspaceDao = WorkspaceDAO();
    workspaceDao.deleteAllUserWorkspaces(userController.user);
  }

  void _deleteUserAccount(){
    UserService userService = UserService();
    userService.deleteUser();
  }
}
