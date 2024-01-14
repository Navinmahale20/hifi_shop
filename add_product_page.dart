import 'package:flutter/material.dart';
import 'product.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}


class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(children: [
            Container(
                height: 200, child: Image.asset('assets/images/cart.jpg')),
            Container(
              alignment: Alignment.topCenter,
              height: 300,
              width: 400,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.transparent),
              child: Column(children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      labelText: 'Product Name',
                      prefixIcon: Icon(Icons.add_box_rounded)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter product name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: priceController,
                  decoration: InputDecoration(
                      labelText: 'Price',
                      prefixIcon: Icon(Icons.currency_rupee)),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter price';
                    }
                    return null;
                  },
                ),
                TextFormField(
                    controller: imageController,
                    decoration: InputDecoration(
                        labelText: 'Image', prefixIcon: Icon(Icons.image))),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      Navigator.pop(
                        context,
                        Product(
                          name: nameController.text,
                          price: double.parse(priceController.text),
                          image: imageController.text,
                        ),
                      );
                    }
                  },
                  child: Text('Add Product'),
                ),
              ]),
            )
          ]),
        ),
      ),
    );
  }
}
