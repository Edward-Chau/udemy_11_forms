import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_11/Provider/grocery_provider.dart';
import 'package:udemy_11/models/grocery_item.dart';

class GroceryScreen extends ConsumerStatefulWidget {
  const GroceryScreen({super.key});

  @override
  ConsumerState<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends ConsumerState<GroceryScreen> {
  void _addItem() {
    Navigator.pushNamed(context, 'addscreeen');
  }

  @override
  Widget build(BuildContext context) {
    final List<GroceryItem> groceryList = ref.watch(groceryProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Grocery',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: groceryList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              width: 30,
              height: 30,
              color: groceryList[index].category.color,
            ),
            title: Text(groceryList[index].name),
            trailing: Text(groceryList[index].quantity.toString()),
          );
        },
      ),
    );
  }
}
