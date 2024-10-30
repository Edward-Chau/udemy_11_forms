import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_11/models/grocery_item.dart';
import 'package:http/http.dart' as http;

class GroceryNotifier extends StateNotifier<List<GroceryItem>> {
  GroceryNotifier() : super([]);

  itemAdd(GroceryItem newItem) async {
    state = [...state, newItem];
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
