import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_11/Provider/grocery_provider.dart';
import 'package:udemy_11/deta/categories.dart';
import 'package:udemy_11/deta/dummy_items.dart';
import 'package:udemy_11/models/grocery_item.dart';
import 'package:http/http.dart' as http;

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
  void initState() {
    loaditem();
    super.initState();
  }

  void loaditem() async {
    final url = Uri.https(
        'udemy12http-default-rtdb.firebaseio.com', 'shopping-list.json');
    final response = await http.get(url);
    final Map<String, dynamic> listdata = json.decode(response.body);
    final List<GroceryItem> tempList = listdata.entries.map((toElement) {
      return GroceryItem(
        id: toElement.key,
        name: toElement.value['name'],
        category: categories[]
        quantity: toElement.value['quantity'],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // final List<GroceryItem> groceryList = ref.watch(groceryProvider);
      final List<GroceryItem> groceryList = tempList;

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
      body: groceryList.isEmpty
          ? const Center(
              child: Text("no item"),
            )
          : ListView.builder(
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
