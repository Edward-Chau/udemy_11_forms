import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:udemy_11/deta/dummy_items.dart';
import 'package:udemy_11/models/grocery_item.dart';

class GroceryNotifier extends StateNotifier<List<GroceryItem>> {
  GroceryNotifier(): super(groceryItems);

 
  
}

final groceryProvider = StateNotifierProvider<GroceryNotifier,List<GroceryItem>>((ref) {
  return GroceryNotifier();
});