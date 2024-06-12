import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/models/product_model.dart';

class AddProductScreen extends StatefulWidget {
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  double _price = 0.0;
  String _imageUrl = '';
  String _category = '';
  bool _discounted = false;
  double _discountPercentage = 0.0;

  Future<void> _addProduct() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final product = Product(
        id: DateTime.now().toString(),
        name: _name,
        price: _price,
        imageUrl: _imageUrl,
        category: _category,
        discounted: _discounted,
        discountPercentage: _discounted ? _discountPercentage : 0.0,
      );

      await FirebaseFirestore.instance
          .collection('products')
          .add(product.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product added successfully!')),
      );

      _formKey.currentState!.reset();
      setState(() {
        _discounted = false;
        _discountPercentage = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавление Продукта'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Имя'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Цена'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите Цену';
                  }
                  return null;
                },
                onSaved: (value) {
                  _price = double.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Изображение'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Загрузите изображение';
                  }
                  return null;
                },
                onSaved: (value) {
                  _imageUrl = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Категория'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите категорию!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _category = value!;
                },
              ),
              SwitchListTile(
                title: Text('Действует скидка'),
                value: _discounted,
                onChanged: (value) {
                  setState(() {
                    _discounted = value;
                  });
                },
              ),
              if (_discounted)
                TextFormField(
                  decoration: InputDecoration(labelText: 'Процент скидки'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a discount percentage';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _discountPercentage = double.parse(value!);
                  },
                ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.green)),
                onPressed: _addProduct,
                child: Text('Добавить продукт', style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
