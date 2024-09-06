import 'package:flutter/material.dart';

import '../common/constants.dart';

class DraggedItemTile extends StatelessWidget {
  final String name;

  const DraggedItemTile({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Text(
        name,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
