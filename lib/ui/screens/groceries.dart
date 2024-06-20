import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/ui/screens/new_item.dart';

import '../../model/grocery_item.dart';

import 'package:http/http.dart' as http;

class Groceries extends StatefulWidget{
  const Groceries({super.key});

  @override
  State<Groceries> createState() => _GroceriesState();
}

class _GroceriesState extends State<Groceries> {

  List<GroceryItem> _groceryItems = [];

  var _isLoading = true;
  // late Future<List<GroceryItem>> _loadedItems;
  String? _error;

  void _loadItems() async{
    final url = Uri.https('shopping-list-50391-default-rtdb.firebaseio.com', 'shopping-list.json');
    try {
      final response = await http.get(url);
      if(response.body == 'null'){
        setState(() {
          _isLoading = false;
        });
        return;
      }
      final Map<String, dynamic> listData = json.decode(response.body);
      final List<GroceryItem> loadedItem = [];
      for(final item in listData.entries){
        final category = categories.entries.firstWhere((element) => element.value.title == item.value['category']).value;
        loadedItem.add(GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value['quantity'],
            category: category));
      }
      setState(() {
        _groceryItems = loadedItem;
        _isLoading = false;
      });
      // return loadedItem;
    } catch (e) {
      setState(() {
            _error = 'Something went wrong. Try later.';
          });
    }
  }

  void _addItem() async{
    final newItem = await Navigator.of(context).push<GroceryItem>(MaterialPageRoute(builder: (context) => const NewItem()));
    if(newItem == null){
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) async{
    final index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });
    final url = Uri.https('shopping-list-50391-default-rtdb.firebaseio.com', 'shopping-list/${item.id}.json');
    final resp = await http.delete(url);
    if(resp.statusCode >= 400){
      setState(() {
        _groceryItems.insert(index, item);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadItems();
  }
  
  @override
  Widget build(BuildContext context){

    Widget content = const Center(
      child: Text('No data saved'),
    );

    if(_isLoading){
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if(_error != null){
      content = Center(
        child: Text(_error!),
      );
    }

    if(_groceryItems.isNotEmpty){
      content = ListView.builder(
          itemCount: _groceryItems.length,
          itemBuilder: (context, index) => Dismissible(
            key: ValueKey(_groceryItems[index].id),
            onDismissed: (direction){
              _removeItem(_groceryItems[index]);
            },
            child: ListTile(
              title: Text(_groceryItems[index].name),
              leading: Container(
                height: 25,
                width: 25,
                color: _groceryItems[index].category.categoryColor,
              ),
              trailing: Text(_groceryItems[index].quantity.toString()),
            ),
          )
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Your Groceries'
        ),
        actions: [
          IconButton(onPressed: _addItem, icon: const Icon(Icons.add))
        ],
      ),
      body: content,
    );
  }
}