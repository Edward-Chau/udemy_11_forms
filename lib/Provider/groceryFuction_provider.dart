import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_11/Provider/getGroceryList_provider.dart';
import 'package:udemy_11/models/grocery_item.dart';
import 'package:http/http.dart' as http;

// final Ref ref;
class GroceryNotifier extends StateNotifier<List<GroceryItem>> {
  GroceryNotifier() : super([]);

  itemAdd(GroceryItem newItem, BuildContext context) async {
    final url = Uri.https(
        'udemy12http-default-rtdb.firebaseio.com', 'shopping-list.json');

    final response = await http.post(
      url,
      headers: {'content-type': 'application/json'},
      body: json.encode(
        {
          'name': newItem.name,
          'quantity': newItem.quantity,
          'category': newItem.category.title
        },
      ),
    );
    // print(response.body); //item id
    // print(response.statusCode); //200
    if (!context.mounted) {
      return;
    }
    Navigator.pop(context);

    final responses = await http.get(url);

    Map<String, dynamic> newList = json.decode(responses.body);

    final List<GroceryItem> tempLoadedItems = newList.entries.map((toElement) {
      final categorie = newList.entries.firstWhere((item) {
        return item.value.title == toElement.value['category'];
      }).value;

      return GroceryItem(
        category: categorie,
        name: toElement.value['name'],
        quantity: toElement.value['quantity'],
        id: toElement.key,
      );
    }).toList();

    state = tempLoadedItems;
  }

  itemDissible(GroceryItem dismissibleItem) {
    state = state.where((item) {
      return item != dismissibleItem;
    }).toList();
  }
}

final groceryProvider =
    StateNotifierProvider<GroceryNotifier, List<GroceryItem>>((ref) {
  return GroceryNotifier();
});
