import 'package:flutter/material.dart';
import 'payment.dart'; 



class ShoppingCart {
  static final List<Map<String, dynamic>> _cartItems = [];

  static List<Map<String, dynamic>> get items => List.unmodifiable(_cartItems);

  static void addItem(Map<String, dynamic> product) {
    _cartItems.add(product);
  }

  static void removeItem(Map<String, dynamic> product) {
    _cartItems.removeWhere((item) => item['name'] == product['name']);
  }

  static void clearCart() {
    _cartItems.clear();
  }

  static double getTotalPrice() {
    double total = 0.0;
    for (var item in _cartItems) {
      try {
        String priceStr = item['price'].toString().replaceAll('\$', '');
        double price = double.parse(priceStr);
        total += price;
      } catch (e) {
        print("Error parsing price for ${item['name']}: ${e}");
      }
    }
    return total;
  }
}

class ShoppingPage extends StatefulWidget {
  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  void _showRemoveItemDialog(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Remove Product"),
          content: Text(
              "Are you sure you want to remove ${item['name']} from your cart?"),
          actions: <Widget>[
            TextButton(
              child: Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: () {
                setState(() {
                  ShoppingCart.removeItem(item);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = ShoppingCart.getTotalPrice();

    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
        backgroundColor: Color.fromARGB(0, 37, 161, 233),
      ),
      body: ShoppingCart.items.isEmpty
          ? Center(
              child: Text("Your cart is empty", style: TextStyle(fontSize: 24)))
          : ListView.builder(
              itemCount: ShoppingCart.items.length,
              itemBuilder: (context, index) {
                final item = ShoppingCart.items[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: Image.asset(item['image'],
                        width: 80, height: 80, fit: BoxFit.cover),
                    title: Text(item['name']),
                    subtitle: Text("\$${item['price']}"),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_shopping_cart, color: Colors.red),
                      onPressed: () => _showRemoveItemDialog(item),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        height: 112,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text("Total: \$${totalPrice.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
              onPressed: () {
                if (ShoppingCart.items.isEmpty) {
                  _showEmptyCartDialog();
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentPage(totalPrice: totalPrice),
                    ),
                  );
                }
              },
              child: Text("Pay Now"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(211, 33, 149, 243),
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                textStyle: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEmptyCartDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Empty Cart"),
          content: Text("You must add items to the cart to make payment."),
          actions: <Widget>[
            TextButton(
              child: Text("Back Home"),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        );
      },
    );
  }
}
