import 'package:flutter/material.dart';
import 'package:flutter_sqflite/models/product.dart';
import 'package:flutter_sqflite/screens/product_add.dart';
import 'package:flutter_sqflite/data/dbHelper.dart';
import 'package:flutter_sqflite/screens/product_detail.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  var dbHelper = DbHelper();
  List<Product>? products;
  int productCount = 0;
  @override
  void initState() {
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((data) {
      setState(() {
        products = data;
        productCount = data.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ürün Listesi',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToProductAdd();
        },
        child: Icon(Icons.add),
        tooltip: 'Yeni ürün Ekle',
      ),
    );
  }

  ListView buildProductList() {
    return ListView.builder(
      itemCount: productCount,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: Text(products![position].name.toString()),
            subtitle: Text(products![position].description.toString() +
                ", " +
                products![position].unitPrice.toString()),
            onTap: () {
              goTODetail(products![position]);
            },
          ),
        );
      },
    );
  }

  void goToProductAdd() async {
    await Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductAdd()));
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((data) {
      setState(() {
        products = data;
        productCount = data.length;
      });
    });
  }

  void goTODetail(Product product) async {
    await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductDetail(product)));
    var productsFuture = dbHelper.getProducts();
    productsFuture.then((data) {
      setState(() {
        products = data;
        productCount = data.length;
      });
    });
  }
}
