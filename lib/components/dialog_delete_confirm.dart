import 'package:flutter/material.dart';
import 'package:grorange/components/dialog_box_title.dart';

class DialogDeleteConfirm extends StatelessWidget {
  final String title;
  final String description;
  final Function onConfirm;

  const DialogDeleteConfirm({
    required this.title,
    required this.description,
    required this.onConfirm,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DialogBoxTitle(title: title),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(description),
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
                    onPressed: () => onConfirm(),
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
