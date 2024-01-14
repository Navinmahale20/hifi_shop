import 'dart:io';

import 'package:flutter/material.dart';

import 'product.dart';

class ProductListWidget extends StatelessWidget {
  final List<Product> productList;
  final Function(int) onDelete;

  ProductListWidget({required this.productList, required this.onDelete});
  @override
  Widget build(BuildContext context) {
    return productList.isEmpty
        ? Center(
            child: Text('No Product Found'),
          )
        : ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return Container(
                  child: Column(children: [
                Stack(
                  children: [
                    Container(
                      child: Image.asset('assets/images/login.jpg',width: 200,height: 200,),
                      height: 100,
                      width: 200,
                    ),
                    Positioned(
                      right: 2,
                      child: IconButton(
                        icon: Icon(Icons.delete_outline),
                        onPressed: () {
                          onDelete(index);
                        },
                      ),
                    )
                  ],
                ),
                Text(
                  productList[index].name,
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  '\$${productList[index].price.toString()}',
                  style: TextStyle(color: Colors.black),
                ),
              ]));
            },
          );
  }
}
