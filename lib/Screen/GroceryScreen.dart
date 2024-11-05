import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_11/Provider/groceryFuction_provider.dart';
import 'package:udemy_11/Provider/listLoading_provider.dart';
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
  // List<GroceryItem> groceryList = [];

  void _addItem() {
    Navigator.pushNamed(context, 'addscreeen');
  }

  // void loaditem() async {
  //   final url = Uri.https(
  //       'udemy12http-default-rtdb.firebaseio.com', 'shopping-list.json');
  //   final response = await http.get(url);
  //   print(response.statusCode); //200
  //   print(response.body); //json format list
  //   Map<String, dynamic> initGrocyList = json.decode(response.body);
  //   // print(initGrocyList);
  //   final List<GroceryItem> tempLoadedItems =
  //       initGrocyList.entries.map((toElement) {
  //     final categorie = categories.entries.firstWhere((item) {
  //       return item.value.title == toElement.value['category'];
  //     });

  //     return GroceryItem(
  //       category: categorie.value,
  //       name: toElement.value['name'],
  //       quantity: toElement.value['quantity'],
  //       id: toElement.key,
  //     );
  //   }).toList();
  //   print('hello');
  //   print(tempLoadedItems);

  //   setState(() {
  //     groceryList = tempLoadedItems;
  //   });
  // }

  // @override
  // void initState() {
  //   loaditem();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // groceryList = tempLoadedItems;
    List<GroceryItem> groceryList = ref.watch(groceryProvider);
    // bool isLoading = ref.watch(groceryProvider.notifier).isLoading;
    bool isLoading = ref.watch(listLoadingProvider);

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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.grey,
              ),
            )
          : groceryList.isEmpty
              ? const Center(
                  child: Text("no item"),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    ref.watch(groceryProvider.notifier).loadItemInit();
                  },
                  child: ListView.builder(
                    itemCount: groceryList.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: ValueKey(groceryList[index].id),
                        onDismissed: (direction) {
                          ref
                              .read(groceryProvider.notifier)
                              .listDissible(groceryList[index], context);
                        },
                        child: ListTile(
                          leading: Container(
                            width: 30,
                            height: 30,
                            color: groceryList[index].category.color,
                          ),
                          title: Text(groceryList[index].name),
                          subtitle: Text('id: ${groceryList[index].id}'),
                          trailing:
                              Text(groceryList[index].quantity.toString()),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
