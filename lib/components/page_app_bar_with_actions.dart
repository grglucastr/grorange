import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grorange/controllers/app_bar_controller.dart';

class PageAppBarWithActions extends StatefulWidget
    implements PreferredSizeWidget {
  final String title;
  final List<IconButton> actions;

  Function? leadButtonAction;
  bool showLeadingButton;

  PageAppBarWithActions({
    required this.title,
    required this.actions,
    this.leadButtonAction,
    this.showLeadingButton = false,
    super.key,
  });

  @override
  Size get preferredSize {
    return const Size(double.maxFinite, 90);
  }

  @override
  State<PageAppBarWithActions> createState() => _PageAppBarWithActionsState();
}

class _PageAppBarWithActionsState<T> extends State<PageAppBarWithActions> {
  final AppBarController appBarController = Get.find();

  @override
  Widget build(BuildContext context) {
    if (widget.showLeadingButton) {
      return _appBarLeadingButton();
    }
    return _appBarNoLeadingButton();
  }

  AppBar _appBarNoLeadingButton() {
    return AppBar(
      title: Obx(() => Text(appBarController.title.value)),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      actions: widget.actions,
    );
  }

  AppBar _appBarLeadingButton() {
    return AppBar(
      title: Obx(() => Text(appBarController.title.value)),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      actions: widget.actions,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () {
          widget.leadButtonAction!();
        },
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
    );
  }
}
