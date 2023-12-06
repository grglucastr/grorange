import 'package:flutter/material.dart';

class PageAppBarWithActions extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final List<IconButton> actions;

  const PageAppBarWithActions({
    required this.title,
    required this.actions,
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

    return AppBar(
      title: Text(widget.title),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      actions: widget.actions,
    );
  }
}
