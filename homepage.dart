import 'package:flutter/material.dart';

import 'product.dart';
import 'ProductListWidget.dart';

import 'add_product_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> productList = [];

  void addProduct(Product product) {
    setState(() {
      productList.add(product);
      saveProductsToSharedPreferences();
    });
  }

  void deleteProduct(int index) {
    setState(() {
      productList.removeAt(index);
      saveProductsToSharedPreferences();
    });
  }

  void saveProductsToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      'products',
      productList.map((product) => product.name).toList(),
    );
  }

  Future<void> loadProductsFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? productNames = prefs.getStringList('products');
    if (productNames != null) {
      setState(() {
        productList = productNames
            .map((name) => Product(name: name, price: 0.0, image: ""))
            .toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadProductsFromSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            'Hi-Fi Shop & Services',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 30,
            ),
          ),
          Text(
            'Audio shop on Rustaveli Ave 57.',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: 10,
            ),
          ),
          Text(
            ' This shop offers both products and services',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: 10,
            ),
          ),
          Text(
            'Products',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          searchBox(),
          Expanded(
            child: ProductListWidget(
              productList: productList,
              onDelete: deleteProduct,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductPage()),
          );
          if (result != null && result is Product) {
            addProduct(result);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

searchBox() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
    decoration: BoxDecoration(
        color: Colors.black12, borderRadius: BorderRadius.circular(30)),
    child: TextField(
      
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(2),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.black,
          size: 20,
        ),
        prefixIconConstraints: BoxConstraints(
          maxHeight: 20,
          maxWidth: 20,
        ),
        border: InputBorder.none,
        hintText: 'Search',
        hintStyle: TextStyle(color: Colors.grey),
      ),
    ),
  );
}

