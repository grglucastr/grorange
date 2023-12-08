import 'package:flutter/material.dart';
import 'package:grorange/components/dialog_box_title.dart';

class DialogEditNames extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final Function onConfirm;

  const DialogEditNames({
    required this.title,
    required this.controller,
    required this.onConfirm,
    super.key,
  });

  @override
  State<DialogEditNames> createState() => _DialogEditNamesState();
}

class _DialogEditNamesState extends State<DialogEditNames> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DialogBoxTitle(title: widget.title),
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
              child: TextField(
                autofocus: true,
                controller: widget.controller,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrangeAccent,
                      minimumSize: const Size(120, 36),
                    ),
                    onPressed: () => widget.onConfirm(),
                    child: const Text(
                      'Confirm',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
