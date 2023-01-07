class Product {
  int? id;
  String? name; // isim
  String? description; // ürün tanım
  double? unitPrice; // birim fiyat
  Product({this.name, this.description, this.unitPrice});
  Product.withID({this.id, this.name, this.description, this.unitPrice});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["name"] = name;
    map["description"] = description;
    map["unitPrice"] = unitPrice;
    if (id != null) {
      map["id"] = id;
    }
    return map; // bidaha bak
  }

  Product.fromObject(dynamic o) {
    this.id = int.tryParse(o["id"].toString()); //bak .tostring()
    this.name = o["name"];
    this.description = o["description"];
    this.unitPrice = double.tryParse(o["unitPrice"].toString());
  }
}
