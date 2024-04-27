import 'package:flutter/material.dart';
import 'payment_tr.dart';

class ShoppingCartTr {
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
        print("Fiyat bulunamadı ${item['name']}: ${e}");
      }
    }
    return total;
  }
}

class ShoppingPageTr extends StatefulWidget {
  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPageTr> {
  void _showRemoveItemDialog(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Ürünü Kaldır"),
          content: Text("Emin misin ${item['name']} karttan silmeye"),
          actions: <Widget>[
            TextButton(
              child: Text("Hayır"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Evet"),
              onPressed: () {
                setState(() {
                  ShoppingCartTr.removeItem(item);
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
    double totalPrice = ShoppingCartTr.getTotalPrice();

    return Scaffold(
      appBar: AppBar(
        title: Text("Kart"),
        backgroundColor: Color.fromARGB(0, 37, 161, 233),
      ),
      body: ShoppingCartTr.items.isEmpty
          ? Center(
              child: Text("Kart Bulunamadı", style: TextStyle(fontSize: 24)))
          : ListView.builder(
              itemCount: ShoppingCartTr.items.length,
              itemBuilder: (context, index) {
                final item = ShoppingCartTr.items[index];
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
              child: Text("Toplam: \$${totalPrice.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
              onPressed: () {
                if (ShoppingCartTr.items.isEmpty) {
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
              child: Text("Öde"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
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
          title: Text("Geçersiz Kart"),
          content: Text("Ödeme yapmak için sepete ürün eklemelisiniz."),
          actions: <Widget>[
            TextButton(
              child: Text("Ana sayfa"),
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
