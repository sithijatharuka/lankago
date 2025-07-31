import 'package:flutter/material.dart';

class PackingList extends StatefulWidget {
  final List<String> packingItems;

  const PackingList({super.key, required this.packingItems});

  @override
  State<PackingList> createState() => _PackingListState();
}

class _PackingListState extends State<PackingList> {
  late Map<String, bool> checkedItems;

  @override
  void initState() {
    super.initState();
    checkedItems = {for (var item in widget.packingItems) item: false};
  }

  void addItem(String newItem) {
    setState(() {
      checkedItems[newItem] = false;
    });
  }

  final TextEditingController _newItemController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            ...checkedItems.keys.map(
              (item) => Row(
                children: [
                  Checkbox(
                    value: checkedItems[item] ?? false,
                    onChanged: (bool? value) {
                      setState(() {
                        checkedItems[item] = value ?? false;
                      });
                    },
                    activeColor: const Color(0xFFFF5722),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _newItemController,
                    decoration: InputDecoration(
                      hintText: 'Add item',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFFFF5722)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (_newItemController.text.trim().isNotEmpty) {
                      addItem(_newItemController.text.trim());
                      _newItemController.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5722),
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _newItemController.dispose();
    super.dispose();
  }
}
