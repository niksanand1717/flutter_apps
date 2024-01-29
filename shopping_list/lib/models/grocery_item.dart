import 'package:shopping_list/models/category.dart';

class GroceryItem {
  const GroceryItem(
      {required String this.id,
      required String this.name,
      required int this.quantity,
      required Category this.category});

  final String id;
  final String name;
  final int quantity;
  final Category category;
}
