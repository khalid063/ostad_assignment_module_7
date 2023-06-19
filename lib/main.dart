import 'package:assignment_module_7_2/style.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});
}



class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Assignment 7.2",
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }

}

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeScreenUI();
  }

}

class HomeScreenUI extends State<HomeScreen>{

  /// Product List
  List<Product> products = [
    Product(name: 'Product 1', price: 10.0),
    Product(name: 'Product 2', price: 15.0),
    Product(name: 'Product 3', price: 20.0),
    Product(name: 'Product 4', price: 80.0),
    Product(name: 'Product 5', price: 50.0),
  ];

  /// Product Counter
  Map<String, int> productCount = {};

  /// Add to cart option
  void addToCart(Product product) {
    setState(() {
      if (productCount.containsKey(product.name)) {
        productCount[product.name] = productCount[product.name]! + 1;
      } else {
        productCount[product.name] = 1;
      }

      if (productCount[product.name] == 5) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Congratulations!'),
            content: Text('You\'ve bought 5 ${product.name}!'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
    });
  }

  int getTotalProductCount() {
    int totalCount = 0;
    productCount.forEach((_, count) {
      totalCount += count;
    });
    return totalCount;
  }



  ///--------------------------------Start Build Method is Start ----------------------------///

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 500,
            color: Colors.white70,
            child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index){
                  final product = products[index];
                  return ListTile(
                    title: Text(
                        product.name,
                      style: myTextStyle(),
                    ),
                    subtitle: Text('\$${product.price.toString()}'),
                    trailing: TextButton(
                        onPressed: () {
                          addToCart(product);
                        },
                        child: Text('Buy Now (${productCount[product.name] ?? 0})'),

                    ),
                  );
                }
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          print("button is clicked");
          Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(productCount)));
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final Map<String, int> productCount;

  CartPage(this.productCount);

  int getTotalProductCount() {
    int totalCount = 0;
    productCount.forEach((_, count) {
      totalCount += count;
    });
    return totalCount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Center(
        child: Text('Total Products: ${getTotalProductCount()}'),
      ),
    );
  }
}

