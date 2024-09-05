import 'package:flutter/material.dart';

class DraggingItemTileWidget extends StatelessWidget {
  final String name;

  const DraggingItemTileWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.blue,
          border: Border.all()),
      child: Center(
        child: Text(name),
      ),
    );
  }
}
