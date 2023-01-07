import 'package:flutter/material.dart';
import 'package:flutter_sqflite/data/dbHelper.dart';
import 'package:flutter_sqflite/models/product.dart';

class ProductDetail extends StatefulWidget {
  Product product;
  ProductDetail(this.product);

  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState(product);
  }
}

enum Options { update, delete }

class _ProductDetailState extends State<ProductDetail> {
  Product product;
  _ProductDetailState(this.product);
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtDescription = TextEditingController();
  var txtUnitPrice = TextEditingController();

  @override
  void initState() {
    txtName.text = product.name.toString();
    txtDescription.text = product.description.toString();
    txtUnitPrice.text = product.unitPrice.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ürün Detayı: ${product.name}",
          style: const TextStyle(
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
        actionsIconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          PopupMenuButton<Options>(
              onSelected: selectProcess,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
                    const PopupMenuItem<Options>(
                      value: Options.update,
                      child: Text("Güncelle"),
                    ),
                    const PopupMenuItem<Options>(
                      value: Options.delete,
                      child: Text("Sil"),
                    ),
                  ]),
        ],
      ),
      body: buildProductDetail(),
    );
  }

  buildProductDetail() {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          buildNameField(),
          buildDescriptionField(),
          buildYnitPrice(),
        ],
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

  void selectProcess(Options options) async {
    switch (options) {
      case Options.delete:
        await dbHelper.delete(product.id!.toInt());
        Navigator.pop(context, true);
        break;
      case Options.update:
        await dbHelper.updata(Product.withID(
            id: product.id,
            name: txtName.text,
            description: txtDescription.text,
            unitPrice: double.tryParse(txtUnitPrice.text)));
        Navigator.pop(context, true);
        break;
      default:
    }
  }
}
