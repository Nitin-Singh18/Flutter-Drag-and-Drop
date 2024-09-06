import 'package:flutter/material.dart';

import '../../common/constants.dart';
import '../../models/item_model.dart';
import '../../widgets/dragged_item_tile.dart';
import '../../widgets/dragging_item_tile_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ItemModel> topItems = [];
  List<ItemModel> bottomItems = [
    const ItemModel(name: "Item 1"),
    const ItemModel(name: "Item 2"),
    const ItemModel(name: "Item 3"),
    const ItemModel(name: "Item 4"),
  ];

  void _addTopItem(ItemModel item) {
    setState(() {
      topItems.add(item);
    });
  }

  void _addBottomItem(ItemModel item) {
    setState(() {
      bottomItems.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          // Upper half
          Expanded(
            child: DragTarget<ItemModel>(
              onAcceptWithDetails: (item) => _addTopItem(item.data),
              builder: (BuildContext context, List<Object?> candidateData,
                  List<dynamic> rejectedData) {
                return topItems.isEmpty
                    ? const Center(child: Text("Drop an item here!"))
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 24),
                        child: ListView.builder(
                          itemCount: topItems.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: Draggable<ItemModel>(
                                data: topItems[index],
                                feedback: Material(
                                  borderRadius:
                                      BorderRadius.circular(borderRadius),
                                  child: SizedBox(
                                    width: width,
                                    child: DraggedItemTile(
                                      name: topItems[index].name,
                                    ),
                                  ),
                                ),
                                childWhenDragging: const Opacity(
                                  opacity: opacity,
                                  child: DraggedItemTile(name: ""),
                                ),
                                child:
                                    DraggedItemTile(name: topItems[index].name),
                                onDragCompleted: () =>
                                    topItems.remove(topItems[index]),
                              ),
                            );
                          },
                        ),
                      );
              },
            ),
          ),

          // Lower half
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: screenVerticalPadding,
                horizontal: screenHorizontalPadding,
              ),
              color: Colors.blue[100],
              child: DragTarget<ItemModel>(
                onAcceptWithDetails: (data) {
                  _addBottomItem(data.data);
                },
                builder: (BuildContext context, List<Object?> candidateData,
                    List<dynamic> rejectedData) {
                  return Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    alignment: WrapAlignment.start,
                    children: bottomItems
                        .map(
                          (item) => Draggable<ItemModel>(
                            data: item,
                            feedback: Material(
                              borderRadius: BorderRadius.circular(borderRadius),
                              child: DraggingItemTileWidget(name: item.name),
                            ),
                            childWhenDragging: const Opacity(
                              opacity: opacity,
                              child: DraggingItemTileWidget(name: ""),
                            ),
                            child: DraggingItemTileWidget(name: item.name),
                            onDragCompleted: () => bottomItems.remove(item),
                          ),
                        )
                        .toList(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
