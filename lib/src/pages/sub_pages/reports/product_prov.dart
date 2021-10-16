// ignore: camel_case_types
class Product_prov {
  String nameProduct;
  int price;
  String priority;

  Product_prov(
      {required this.nameProduct, required this.price, required this.priority});

  static List<Product_prov> getUsers() {
    return <Product_prov>[
      Product_prov(
          nameProduct: "Crema para el cuerpo", price: 52000, priority: "Media"),
      Product_prov(nameProduct: "Bon yourt", price: 2100, priority: "Baja"),
      Product_prov(nameProduct: "Perfume", price: 86000, priority: "Baja"),
      Product_prov(nameProduct: "Jugo de mango", price: 2900, priority: "Baja"),
      Product_prov(nameProduct: "Arriendo", price: 1000000, priority: "Alta"),
    ];
  }
}
