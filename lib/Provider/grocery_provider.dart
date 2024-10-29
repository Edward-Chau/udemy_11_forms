import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_11/models/grocery_item.dart';

class GroceryNotifier extends StateNotifier<List<GroceryItem>> {
  GroceryNotifier() : super([]);

  itemAdd(GroceryItem newItem) {
    state = [...state, newItem];
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
