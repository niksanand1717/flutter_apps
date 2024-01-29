import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/data/categories.dart';
import 'dart:convert';

// import 'package:shopping_list/data/dummy_items.dart';
import 'package:shopping_list/widgets/new_item.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  var _groceryItems = [];
  var _isLoading = true;
  Color _dismissedColor = Colors.red;
  var _direction;
  String? _error;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(
        'shopping-list-80bc7-default-rtdb.asia-southeast1.firebasedatabase.app',
        'shopping-list.json');
    final response = await http.get(url);
    print(response.toString());
    if (response.statusCode >= 400) {
      setState(() {
        _error = 'Some error occurred while fetching data, try again later!';
      });
    }
    if (response.body == 'null') {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    // final Map<String, Map<String, dynamic>> listData =
    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> _loadedItems = [];
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere((catItem) => catItem.value.type == item.value['category'])
          .value;
      _loadedItems.add(GroceryItem(
        id: item.key,
        name: item.value['name'],
        quantity: item.value['quantity'],
        category: category,
      ));
    }
    setState(() {
      _groceryItems = _loadedItems;
      _isLoading = false;
    });
  }

  void _addItem() async {
    // final new_item =
    final newItem = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => NewItem(),
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });

    //
    // if (new_item == null) {
    //   return;
    // }

    // setState(() {
    //   _groceryItems.add(new_item);
    // });
  }

  void _removeItem(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Item Deleted ${item.name}'),
      duration: Duration(seconds: 2),
    ));
    final url = Uri.https(
        'shopping-list-80bc7-default-rtdb.asia-southeast1.firebasedatabase.app',
        'shopping-list/${item.id}.json');
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(index, item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _toShow;

    if (_groceryItems.isEmpty) {
      _toShow = const Center(
        child: Text('Nothing to Show'),
      );
    }
    if (_isLoading) {
      _toShow = Center(child: const CircularProgressIndicator());
    }
    print('ERROR MSG :: ${_error}');
    if (_error != null) {
      _toShow = Container(
        color: Colors.red,
        height: 100,
        width: 100,
        child: Center(
          child: Text(_error!),
        ),
      );
    } else {
      _toShow = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) => Dismissible(
          background: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Expanded(
              //   child: Container(
              //     color: Colors.green,
              //     // ? _dismissedColor
              //     // : Colors.green,
              //     child: Center(
              //       child: Text('Edit',
              //           style: GoogleFonts.montserrat(
              //               textStyle: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             fontSize: 22,
              //             color: Colors.white,
              //           ))),
              //     ),
              //   ),
              // ),
              Expanded(
                child: Container(
                  color: Colors.red,
                  // ? _dismissedColor
                  // : Colors.green,
                  child: Center(
                    child: Text('Swipe to Delete',
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white,
                        ))),
                  ),
                ),
              ),
            ],
          ),
          key: ValueKey(_groceryItems[index].id),
          onDismissed: (direction) {
            // print(direction == DismissDirection.startToEnd);
            _removeItem(_groceryItems[index]);
          },
          child: ListTile(
            title: Text(_groceryItems[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text(
              _groceryItems[index].quantity.toString(),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Grocery"),
        actions: [
          IconButton(
            onPressed: () {
              _addItem();
            },
            icon: Icon(
              Icons.add,
              size: 36,
            ),
          )
        ],
      ),
      body: Container(
        child: _toShow,
      ),
    );
  }
}
