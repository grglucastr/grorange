import 'package:flutter/material.dart';
import 'package:grorange/core_widgets/grid_button.dart';

class GridOptions extends StatelessWidget {
  final List<GridButton> buttons;

  const GridOptions({required this.buttons, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        scrollDirection: Axis.vertical,
        itemCount: buttons.length,
        itemBuilder: (context, index) => Center(
          child: buttons[index],
        ),
      ),
    );
  }
}
