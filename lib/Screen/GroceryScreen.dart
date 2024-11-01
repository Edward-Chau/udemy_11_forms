import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_11/Provider/groceryFuction_provider.dart';
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

  void loaditem() async {
    final url = Uri.https(
        'udemy12http-default-rtdb.firebaseio.com', 'shopping-list.json');
    final response = await http.get(url);
    print(response.statusCode); //200
    print(response.body); //json format list
    Map<String, dynamic> initGrocyList = json.decode(response.body);
    print(initGrocyList);
  }

  @override
  void initState() {
    loaditem();
    super.initState();
  }
  //need init?
  //do two times? when init & add item?

  @override
  Widget build(BuildContext context) {
    final List<GroceryItem> groceryList = ref.watch(groceryProvider);
    // final List<GroceryItem> groceryList = tempList;

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
