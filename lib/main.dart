import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product('Product 1', 10),
    Product('Product 2', 20),
    Product('Product 3', 30),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage(products: products)),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductItem(
            product: products[index],
            onBuyNowPressed: () {
              setState(() {
                products[index].buyCount++;
                if (products[index].buyCount == 5) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Congratulations!'),
                        content: Text('You\'ve bought 5 ${products[index].name}!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              });
            },
          );
        },
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  int buyCount;

  Product(this.name, this.price) : buyCount = 0;
}

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onBuyNowPressed;

  ProductItem({required this.product, required this.onBuyNowPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(product.name.substring(0, 1)),
      ),
      title: Text(product.name),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      trailing: TextButton(
        onPressed: onBuyNowPressed,
        child: Text('Buy Now (${product.buyCount})'),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Product> products;

  CartPage({required this.products});

  @override
  Widget build(BuildContext context) {
    int totalBuyCount = products.fold(0, (sum, product) => sum + product.buyCount);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Center(
        child: Text(
          'Total Products: $totalBuyCount',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
