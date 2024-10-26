
import 'package:udemy_11/models/category.dart';

class GroceryItem{
  const GroceryItem({required this.category, required this.name,required this.quantity, required this.id});

final String id;
final String name;
final int quantity;
final Category category;

}