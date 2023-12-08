import 'package:flutter/material.dart';

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

class _PageAppBarWithActionsState extends State<PageAppBarWithActions> {
  @override
  Widget build(BuildContext context) {

    if(widget.showLeadingButton){
      return _appBarLeadingButton();
    }
    return _appBarNoLeadingButton();

  }

  AppBar _appBarNoLeadingButton() {
    return AppBar(
      title: Text(widget.title),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      actions: widget.actions,
    );
  }

  AppBar _appBarLeadingButton() {
    return AppBar(
      title: Text(widget.title),
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
