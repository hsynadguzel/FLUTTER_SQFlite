import 'package:flutter/material.dart';
import 'package:flutter_sqflite/data/dbHelper.dart';
import 'package:flutter_sqflite/models/product.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({Key? key}) : super(key: key);

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ürün Ekleme",
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            buildNameField(),
            buildDescriptionField(),
            buildYnitPrice(),
            buildSaveButton(),
          ],
        ),
      ),
    );
  }

  buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: 'Ürün Adı'),
      controller: txtName,
    );
  }

  buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(labelText: 'Ürün Açıklaması'),
      controller: txtDescription,
    );
  }

  buildYnitPrice() {
    return TextField(
      decoration: InputDecoration(labelText: 'Birim Fiyatı (TL)'),
      controller: txtUnitPrice,
    );
  }

  buildSaveButton() {
    return FlatButton(
      onPressed: () {
        addProduct();
      },
      child: Text('Ekle'),
    );
  }

  void addProduct() async {
    var result = await dbHelper.insert(
      Product(
        name: txtName.text,
        description: txtDescription.text,
        unitPrice: double.tryParse(txtUnitPrice.text),
      ),
    );
    Navigator.pop(context, true);
  }
}
