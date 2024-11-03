import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_11/Provider/getGroceryList_provider.dart';
import 'package:udemy_11/deta/categories.dart';
import 'package:udemy_11/models/grocery_item.dart';
import 'package:http/http.dart' as http;

// final Ref ref;
class GroceryNotifier extends StateNotifier<List<GroceryItem>> {
  GroceryNotifier() : super([]) {
    loadItemInit();
  } //will load item when .watch in first time
  final url = Uri.https(
      'udemy12http-default-rtdb.firebaseio.com', 'shopping-list.json');

  Future<List<GroceryItem>> getHTTPItem() async {
    final initrespones = await http.get(url);
    Map<String, dynamic> initList = json.decode(initrespones.body);

    List<GroceryItem> mapingList = initList.entries.map((toElement) {
      final categorie = categories.entries.firstWhere((item) {
        return item.value.title == toElement.value['category'];
      });

      return GroceryItem(
          category: categorie.value,
          name: toElement.value['name'],
          quantity: toElement.value['quantity'],
          id: toElement.key);
    }).toList();

    return mapingList;
  }

  loadItemInit() async {
    Future<List<GroceryItem>> mapingList = getHTTPItem();

    state = await mapingList; //load item when app is start
  }

  itemAdd(GroceryItem item, BuildContext context) async {
    http.post(
      url,
      // headers: {'Content-Type': 'applicatio/json'},
      body: json.encode(
        {
          'category': item.category.title,
          'name': item.name,
          'quantity': item.quantity
        },
      ),
    );
    List<GroceryItem> updateList = await getHTTPItem();
    state = updateList;
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  listDissible(GroceryItem removeItem) async {
//  List<GroceryItem> editList = await getHTTPItem();
//  List<GroceryItem> newList=editList.where((eachItem){return eachItem!=removeItem;}).toList();

// http.post(url);
  }
}

final groceryProvider =
    StateNotifierProvider<GroceryNotifier, List<GroceryItem>>((ref) {
  return GroceryNotifier();
});
