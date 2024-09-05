import 'package:flutter/material.dart';

import '../../models/item_model.dart';
import '../../widgets/dragged_item_tile.dart';
import '../../widgets/dragging_item_tile_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color targetColor = Colors.grey;
  List<ItemModel> droppedItems = [];
  List<ItemModel> draggingItems = [
    const ItemModel(name: "Item 1"),
    const ItemModel(name: "Item 2"),
    const ItemModel(name: "Item 3"),
    const ItemModel(name: "Item 4"),
  ];

  void _addItem(ItemModel item) {
    setState(() {
      droppedItems.add(item);
      draggingItems.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: DragTarget<ItemModel>(
              onAcceptWithDetails: (data) {
                _addItem(data.data);
              },
              builder: (context, candidateData, rejectedData) {
                return droppedItems.isEmpty
                    ? const Center(
                        child: Text("Drop an item!"),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: ListView.builder(
                            itemCount: droppedItems.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  DraggedItemTile(
                                      name: droppedItems[index].name),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              );
                            }),
                      );
              },
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              color: Colors.blue[100],
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.start,
                children: draggingItems
                    .map(
                      (item) => Draggable<ItemModel>(
                        data: item,
                        feedback: Material(
                          borderRadius: BorderRadius.circular(12),
                          child: DraggingItemTileWidget(name: item.name),
                        ),
                        childWhenDragging: const Opacity(
                            opacity: 0.4,
                            child: DraggingItemTileWidget(name: "")),
                        child: DraggingItemTileWidget(name: item.name),
                        onDragCompleted: () => setState(() {
                          draggingItems.remove(item);
                        }),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
